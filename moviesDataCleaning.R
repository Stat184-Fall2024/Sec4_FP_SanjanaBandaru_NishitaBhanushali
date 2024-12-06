library(tidyverse)

moviesRaw <- read_csv(
  file = "~/Desktop/STAT184/IMDBMovies.csv"
)

moviesCleaned <- moviesRaw %>%
  dplyr:: select(-id, -vote_average, -vote_count, -overview, -adult, 
  -backdrop_path, -homepage, -tconst, -poster_path, -tagline, -keywords, 
  -directors, -writers, -cast, -original_title, -popularity
  ) %>%
  filter(grepl('English', spoken_languages)) %>%
  dplyr:: select(-original_language, -spoken_languages) %>%
  filter(grepl('20', release_date)) %>%
  filter(status == "Released") %>%
  filter(runtime != "0") %>%
  filter(revenue != "0") %>%
  filter(budget != "0") %>%
  filter(!duplicated(title))

View(moviesCleaned)
