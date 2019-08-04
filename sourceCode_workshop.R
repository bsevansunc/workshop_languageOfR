#==========================================================================*
# ---- functions ----
#==========================================================================*

# Function searches packages in installed package list, adds them if you 
# don't have them, and loads the library:

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

#==========================================================================*
# ---- packages, settings, and options ----
#==========================================================================*

# Add packages ------------------------------------------------------------

smartLibrary(c('tidyverse', 'lubridate', 'stringr'))

rename <- dplyr::rename

select <- dplyr::select


# Provide the file read location ------------------------------------------

url <- 'https://raw.githubusercontent.com/bsevansunc/workshop_languageOfR/master'

#==========================================================================*
# ---- data ----
#==========================================================================*

# Motor trend car facts ---------------------------------------------------

motorTrend <- mtcars %>%
  mutate(model = rownames(mtcars)) %>%
  slice(-c(2, 4, 6, 26, 27, 29)) %>%
  separate(model, sep = ' ', into = c('make', 'model')) %>%
  arrange(make, model) %>%
  select(make, model, mpg:carb)


# States in 1975 ----------------------------------------------------------

states1975 <- data_frame(
  region = state.region,
  division = state.division,
  state = state.name,
  area = state.area,
  population = state.x77[, 'Population']
)


# Tidy iris data ----------------------------------------------------------

irisTbl <- tbl_df(iris) %>%
  rename(
    sepalLength = Sepal.Length,
    sepalWidth = Sepal.Width,
    petalLength = Petal.Length,
    petalWidth = Petal.Width,
    species = Species
  )


# World Health Organization's population dataset --------------------------

whoPopulation <- population


# Star wars! --------------------------------------------------------------

measurements <- starwars %>%
  select(name, height, mass) %>%
  filter(!is.na(mass))

origins <- starwars %>%
  select(name, homeworld, species) %>%
  filter(name %in% measurements$name)


# Bird point count and banding data ---------------------------------------

birdCounts <- readGit_csv(url, 'birdCounts.csv')

birdMeasures <- readGit_csv(url, 'bandingRecord.csv')


# Bird trait data ---------------------------------------------------------

birdHabits <- readGit_csv(url, 'birdHabits.csv')


#==========================================================================*
# ---- remove unnecessary functions ----
#==========================================================================*

rm(list = c('url', 'fibFun', 'readGit_csv', 'smartLibrary', 'theme_add'))
