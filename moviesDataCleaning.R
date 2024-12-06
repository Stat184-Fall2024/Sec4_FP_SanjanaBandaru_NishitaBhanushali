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

View(moviesCleaned)
