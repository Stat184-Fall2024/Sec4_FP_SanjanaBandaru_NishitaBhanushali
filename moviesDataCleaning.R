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
  filter(runtime <= 220) %>%
  filter(budget >= 1000) %>%
  filter(numVotes >= 1000) %>%
  filter(!duplicated(title)) %>%
  filter(!grepl('UFC', title)) %>%
  drop_na()

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
  summarize(
    minRev = min(revenue),
    Q1Rev = quantile(revenue, probs = 0.25),
    medianRev = median(revenue),
    Q3Rev = quantile(revenue, probs = 0.75),
    maxRev = max(revenue),
    avgRev = mean(revenue),
    minRating = min(averageRating),
    Q1Rating = quantile(averageRating, probs = 0.25),
    medianRating = median(averageRating),
    Q3Rating = quantile(averageRating, probs = 0.75),
    maxRating = max(averageRating),
    avgRating = mean(averageRating),
    minRun = min(runtime),
    Q1Run = quantile(runtime, probs = 0.25),
    medianRun = median(runtime),
    Q3Run = quantile(runtime, probs = 0.75),
    maxRun = max(runtime),
    avgRun = mean(runtime),
    count = n(),
    .groups = "drop"
  )


View(moviesCleaned)
