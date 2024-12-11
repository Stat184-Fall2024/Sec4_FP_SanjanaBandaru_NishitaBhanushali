library(tidyverse)

moviesRaw <- read_csv(
  file = "~/Desktop/STAT184/IMDBMovies.csv"
)

moviesCleaned <- moviesRaw %>%
  dplyr:: select(-id, -vote_average, -vote_count, -overview, 
  -backdrop_path, -homepage, -tconst, -poster_path, -tagline, -keywords, 
  -directors, -writers, -cast, -original_title, -popularity
  ) %>%
  filter(adult == FALSE) %>%
  filter(grepl('English', spoken_languages)) %>%
  filter(original_language == "en") %>%
  dplyr:: select(-original_language, -spoken_languages, -adult) %>%
  filter(!grepl('19', release_date)) %>%
  filter(status == "Released") %>%
  filter(revenue > 1) %>%
  filter(runtime >= 30 ) %>%
  filter(budget >=  1000) %>%
  filter(numVotes >=  1000) %>%
  filter(!duplicated(title)) %>%
  filter(!grepl('UFC', title)) %>%
  drop_na()

info <- list(
  Count = ~as.double(n()),
  Min = ~as.double(min(.x)),
  Q1 = ~as.double(quantile(.x,probs = 0.25, na.rm = TRUE)),
  Median = ~as.double(median(.x)),
  Avg = ~as.double(mean(.x)),
  Q3 = ~as.double(quantile(.x,probs = 0.75, na.rm = TRUE)),
  Max = ~as.double(max(.x))
)

genresWrangled <- moviesCleaned %>%
  separate_wider_delim(
    cols = genres,
    delim = ",",
    names = c("Genre1", "Genre2", "Genre3", "Genre4", "Genre5", "Genre6",
    "Genre7", "Genre8", "Genre9"),
    too_few = "align_start"
  ) %>%
  pivot_longer(
    cols = starts_with("Genre"),
    names_to = "genreNumber",
    values_to = "genre"
  ) %>%
  drop_na() %>%
  mutate(
    genre = case_match(
      .x = genre,
      " Action" ~ "Action",
      " Adventure" ~ "Adventure",
      " Crime" ~ "Crime",
      " Thriller" ~ "Thriller",
      " Science Fiction" ~ "Science Fiction",
      " Drama" ~ "Drama",
      " Comedy" ~ "Comedy",
      " TV Movie" ~ "TV Movie",
      " Family" ~ "Family",
      " Western" ~ "Western",
      " Mystery" ~ "Mystery",
      " Romance" ~ "Romance",
      " History" ~ "History",
      " War" ~ "War",
      " Fantasy" ~ "Fantasy",
      " Horror" ~ "Horror",
      " Music" ~ "Music",
      " Documentary" ~ "Documentary",
      " Animation" ~ "Animation",
      .default = genre
    )
  ) %>% 
 group_by(genre) %>%
  summarize(across(c(revenue,budget,runtime), info)) %>%
  select(-runtime_Count, -budget_Count) %>%
  rename(count = revenue_Count)
