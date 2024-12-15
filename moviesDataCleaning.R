library(tidyverse)
library(readr)
library(dplyr)

##Importing the Data----
fantasyRaw <- read_csv(
  file = "~/Desktop/STAT184/fantasy.csv"
)

actionRaw <- read_csv(
  file = "~/Desktop/STAT184/action.csv"
)

horrorRaw <- read_csv(
  file = "~/Desktop/STAT184/horror.csv"
)

mysteryRaw <- read_csv(
  file = "~/Desktop/STAT184/mystery.csv"
)

##Merging the Data----
moviesRaw <- full_join(
  x = fantasyRaw,
  y = actionRaw
) %>%
  full_join(
    y = horrorRaw
  ) %>%
  full_join(
    y = mysteryRaw
  ) 

##Cleaning the Data----
moviesCleaned <- moviesRaw %>%
  rename(revenue = `gross(in $)`
  ) %>%
  dplyr:: select(-movie_id, -description, -director_id, -star_id
  ) %>%
  drop_na() %>%
  filter(!grepl('19', year)) %>%
  filter(!duplicated(movie_name)) %>%
  mutate(runtime = readr::parse_number(runtime))

info <- list(
  Count = ~as.double(n()),
  Min = ~as.double(min(.x)),
  Q1 = ~as.double(quantile(.x,probs = 0.25, na.rm = TRUE)),
  Median = ~as.double(median(.x)),
  Avg = ~as.double(mean(.x)),
  Q3 = ~as.double(quantile(.x,probs = 0.75, na.rm = TRUE)),
  Max = ~as.double(max(.x))
)

moviesWrangled <- moviesCleaned %>%
  separate_wider_delim(
    cols = genre,
    delim = ",",
    names = c("Genre1", "Genre2", "Genre3"),
    too_few = "align_start"
  ) %>%
  pivot_longer(
    cols = starts_with("Genre"),
    names_to = "genreNumber",
    values_to = "genre"
  ) %>%
  mutate(
    genre = case_match(
      .x = genre,
      " Action" ~ "Action",
      " Mystery" ~ "Mystery",
      " Fantasy" ~ "Fantasy",
      " Horror" ~ "Horror"
    )) %>%
  group_by(genre) %>%
  summarize(across(c(revenue,runtime,rating), info)) %>%
  select(-runtime_Count) %>%
  drop_na() %>%
  rename(count = revenue_Count) 

genres <- moviesCleaned %>%
  separate_wider_delim(genre, ",", names = c("genre1", "genre2", "genre3"), too_few = "align_start")

firstGenres <- genres %>%
  filter(genre1 == "Action" | genre1 == "Horror" | genre1 == "Mystery" | genre1 == "Fantasy")


test <- moviesCleaned %>%
  separate_wider_delim(
    cols = genre,
    delim = ",",
    names = c("Genre1", "Genre2", "Genre3"),
    too_few = "align_start"
  )

firstGenres <- test %>%
  filter(Genre1 == "Action" | Genre1 == "Horror" | Genre1 == "Mystery" | Genre1 == "Fantasy")




