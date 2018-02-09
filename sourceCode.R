#=================================================================================*
# ---- functions ----
#=================================================================================*

# Function searches packages in installed package list, adds them if you don't have them, and loads the library:

smartLibrary <- function(packageVector){
  for(i in 1:length(packageVector)){
    package <- packageVector[i]
    if(!package %in% rownames(installed.packages())){
      install.packages(packageVector[i],repos="http://cran.rstudio.com/",
                       dependencies=TRUE)
    }
  }
  lapply(packageVector, library, character.only = TRUE)
}

# Add theme to all plot output:

theme_add <- function(){
  theme(
    axis.title = element_text(size = rel(1.5))
  )
}

# Read github csv:

readGit_csv <- function(url, filename){
  # Location of file:
  fileUrl <- getURL(
    paste(url, filename, sep = '/')
  )
  # Read file
  outFrame <- read.csv(text = fileUrl, stringsAsFactors = FALSE) %>%
    tbl_df
  return(outFrame)
}

# Fibonacci:

fibFun <- function(seed, howLong){
  v <- vector('numeric', length = howLong)
  v[1:2] <- seed
  for(i in 3:length(v)){
    v[i] <- v[i-1]+v[i-2]
  }
  return(v)
}

#=================================================================================*
# ---- packages, settings, and options ----
#=================================================================================*

# Add packages:

smartLibrary('tidyverse')

# Options:

knitr::opts_chunk$set(echo = TRUE)

rename <- dplyr::rename

select <- dplyr::select

# Provide the file read location:

url <- 'https://raw.githubusercontent.com/bsevansunc/workshop_languageOfR/master'

#=================================================================================*
# ---- data ----
#=================================================================================*
# ---- vectors ----
#---------------------------------------------------------------------------------*

# Some vectors:

v <- fibFun(c(1,1), 5)

exampleFactor <- factor(c('three','two','one', 'one'))

monthFactor <- month.name[1:6] %>%
  sample(size = 10,  replace = TRUE) %>%
  tolower %>% 
  factor

exampleFactorLevels <- factor(
  exampleFactor,
  levels = c('one', 'two', 'three')
)

exampleFactorLabels <- factor(
  exampleFactorLevels,
  labels = c('One', 'Two', 'Three')
)

numericVector <- fibFun(c(1,1), 4)

#---------------------------------------------------------------------------------*
# ---- data frames ----
#---------------------------------------------------------------------------------*

# Dummy data frame:

dummyData <-  data.frame(
  gen = c('a', 'b', 'a', 'a', 'b'),
  n = fibFun(c(3,5), 5)
  )

# Tidy up iris:

irisTbl <- tbl_df(iris) %>%
  rename(
    sepalLength = Sepal.Length,
    sepalWidth = Sepal.Width,
    petalLength = Petal.Length,
    petalWidth = Petal.Width,
    species = Species
  )

# World Health Organization's population dataset:

population

# Bird point count data:

birdCounts <- readGit_csv(url, 'birdCounts.csv')

# Bird trait data:

birdHabits <- readGit_csv(url, 'birdHabits.csv')

# Species richness

birdRichness <- birdCounts %>%
  group_by(site) %>% 
  summarize(richness = length(unique(species))) %>%
  sample_n(10) %>%
  mutate(area = sample(1:20, 10, replace = TRUE)) %>%
  select(site, area)

motorTrend <- mtcars %>%
  mutate(model = rownames(mtcars)) %>%
  slice(-c(2, 4, 6, 26, 27, 29)) %>%
  separate(model, sep = ' ', into = c('make', 'model')) %>%
  arrange(make, model) %>%
  select(make, model, mpg:carb)

states1975 <- data_frame(
  region = state.region,
  division = state.division,
  state = state.name,
  area = state.area,
  population = state.x77[, 'Population']
)

# Star wars!

measurements <- starwars %>%
  select(name, height, mass) %>%
  filter(!is.na(mass))

origins <- starwars %>%
  select(name, homeworld, species) %>%
  filter(name %in% measurements$name)

#---------------------------------------------------------------------------------*
# ---- other object classes ----
#---------------------------------------------------------------------------------*

# Example matrix objects:

m <- matrix(fibFun(c(1,1), 6), ncol = 2)

exampleMatrix <- sample(1:5, 60, replace = TRUE) %>%
  matrix(ncol = 3, byrow = TRUE)

# Add a treatment vector the matrix after converting to a data frame:

treatmentVector <- sample(letters[1:2], 10, replace = TRUE)



