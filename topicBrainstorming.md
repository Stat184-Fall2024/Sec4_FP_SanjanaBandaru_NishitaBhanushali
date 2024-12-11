## Possible Data Sets to Explore:
- Microsoft Stock Data (2010-2024): https://www.kaggle.com/datasets/mhassansaboor/microsoft-stock-data-2010-2024
- Animal Crossing villagers (Entire Series): https://www.kaggle.com/datasets/nookipedia/animal-crossing-series-villagers
- Most Dangerous Countries for Women 2024: https://www.kaggle.com/datasets/arpitsinghaiml/most-dangerous-countries-for-women-2024
- [TMDB + IMDB Merged Movies Dataset: https://www.kaggle.com/datasets/ggtejas/tmdb-imdb-merged-movies-dataset] - SELECTED
- Bechdel by FiveThirtyEight: https://github.com/fivethirtyeight/data/tree/master/bechdel
- College Majors by FiveThirtyEight: https://github.com/fivethirtyeight/data/tree/master/college-majors
- Spotify Most Streamed Songs: https://www.kaggle.com/datasets/abdulszz/spotify-most-streamed-songs
- Avengers by FiveThirtyEight: https://github.com/fivethirtyeight/data/tree/master/avengers


Plan:
12/4 - Figure out Data
For at home:
- Sanjana - Data Wrangling
- Jesa - Skeleton Quarto File
- Nishita - Skeleton Quarto File

Potential Research Questions:
- Exploring the relationship between vote average, revenue, runtime
- Filter by release date (only want movies from 11/21/2010-3/24/2015)

Filter with:
- averageRating
- production_countries
- genres
- title
- release_date
- revenue
- runtime
- status
- budget
- original language
- production_companies
- spoken_languages
- numVotes

Create a set of research questions:
1. How does genre affect voting average? - Qual
2. What's the relationship between revenue and voting average? - Quant
3. How does run time affect voting average? - Quant
4. How does genre affect run time? - Qual
5. How does genre affect revenue? - Qual
6. How does run time affect revenue? - Quant
7. What is the relationship between genre, revenue, runtime, and voting average. - Qual


Coding Work Breakdown:
- Data Wrangling - Sanjana
- Visualizations
  - Quantitative - Nishita
  - Qualitative + Summary Stats Table - Jesa
  

Writing Work Breakdown:
- Introduction
- Methodology
- Quantitative EDA
- Qualitative EDA
- Results/Conclusion


Group Questions:
- Should we really keep at this with 4 variables? I think we could drop runtime and not suffer.
- How do we want to split up the writing?
- Struggling with the summary stats table
  - Could do just a frequency table for genre to get context for the averages
  - Did a 3-way graph with runtime, revenue, and rating, necessary? Genre really doesn't want to be graphed in 4D.
  - Summary table for just genre?
  - Should we evaluate everything in the context of rating? or revenue? -> then could do a linear model
  - 



