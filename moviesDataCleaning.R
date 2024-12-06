library(tidyverse)

moviesRaw <- read_csv(
  file = "~/Desktop/STAT184/IMDBMovies.csv"
)

moviesCleaned <- moviesRaw %>%
  dplyr:: select(-id, -vote_average, -vote_count, -overview, -adult, 
  -backdrop_path, -homepage, -tconst, -poster_path, -tagline, -keywords, 
  -directors, -writers, -cast, -original_title, -popularity, -spoken_languages
  ) %>%
  filter(original_language == "en") %>%
  dplyr:: select(-original_language) %>%
  filter(grepl('201', release_date)) %>%
  filter(status == "Released")


View(moviesCleaned)