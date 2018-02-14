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

whoPopulation <- population

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

options(stringsAsFactors = FALSE)

generateObservationID <- function(){
  n1 <- sample(100:999,1)
  l1 <- sample(letters,1)
  n2 <- sample(1000:9999, 1)
  l2 <- sample(letters, 1)
  paste0(l1, n1, '-', n2, l2)
}

obs1 <- generateObservationID()
obs2 <- generateObservationID()
obs3 <- generateObservationID()
obs4 <- generateObservationID()
obs5 <- generateObservationID()
obs6 <- generateObservationID()

# 1NF:  Each row is an observation:

messy1NFa <- data.frame(id = obs1,
                        birdID = rep('1123-58132', 3), 
                        observationDate = rep('2016-05-16', 3),
                        measurement = c('mass', 'wing', 'tail'),
                        value = c(34.5, 96.7, 107)
)

tidy1NFa <-
  data.frame(id = rep(obs1, 3),
             birdID = rep('1123-58132', 3),
             observationDate = rep('2016-05-16', 3),
             measurement = c('mass', 'wing', 'tail'),
             value = c(34.5, 96.7, 107)
  ) %>%
  spread(measurement, value)

# 1NF: All values are atomic

badDate <- data.frame(birdID = c('1123-58132', '1123-58133','1123-58134'), 
                        observationDate = c('2016-05-16, 2017-07-12', '2016-05-26', '2016-06-02, 2017-05-12')
) %>% tbl_df

# Fixed, but breaks the first rule

tidy1NFb0 <- data.frame(birdID = c('1123-58132', '1123-58133','1123-58134'), 
                        observationDate = c('2016-05-16,2017-07-12', '2016-05-26', '2016-06-02,2017-05-12')
) %>% 
  separate(observationDate, into = c('date1', 'date2'), sep = ',')

tidy1NFb <- data.frame(birdID = c('1123-58132', '1123-58133','1123-58134'), 
                       observationDate = c('2016-05-16,2017-07-12', '2016-05-26', '2016-06-02,2017-05-12')
) %>% 
  separate(observationDate, into = c('date1', 'date2'), sep = ',') %>%
  gather(key = date, value = observationDate, -birdID, na.rm = TRUE) %>%
  select(birdID, observationDate) %>%
  mutate(id = c(obs1, obs2, obs3, obs4, obs5)) %>%
  select(id, birdID:observationDate)

# 1NF: No repeated groupings of columns

messy1NFc <- data.frame(
  id = c(obs1, obs2, obs3),
  birdID = c('1123-58132', '1123-58133','1123-58134'), 
  observationDate1 = c('2016-05-16', '2016-05-16', '2016-06-02'),
  observationDate2 = c('2017-07-12', NA, '2017-05-12'),
  mass1 = c(34.5, 35.7, 38.0),
  mass2 = c(36.2, NA, 37.6)
)

exampleTidy1 <- data.frame(birdID = c('1123-58132', '1123-58133','1123-58134'), 
                           observationDate1 = c('2016-05-16', '2016-05-16', '2016-06-02'),
                           observationDate2 = c('2017-07-12', NA, '2017-05-12')) %>%
  gather(date, observationDate, -birdID, na.rm = TRUE) %>%
  select(-date) %>%
  bind_cols(
    data.frame(birdID = c('1123-58132', '1123-58133','1123-58134'), 
               mass1 = c(34.5, 35.7, 38.0),
               mass2 = c(36.2, NA, 37.6)
    ) %>%
      gather(massMeasure, mass, -birdID, na.rm = TRUE) %>%
      select(-c(birdID, massMeasure))
  ) %>%
  mutate(id = c(obs1, obs2, obs3, obs4, obs5)) %>%
  select(id, birdID:mass)

# 2NF: All columns are unique to the primary key:

messy2NF <- exampleTidy1 %>%
  mutate(
    site = c('apple','apple', 'avocado', 'apple', 'avocado'),
    canopyCover = c(32.5, 32.5, 78.4, 32.5, 78.4)
  ) %>%
  select(id, birdID, observationDate, site, canopyCover, mass)

tidy2NFobsLevel <- messy2NF %>%
  select(id, birdID, site, observationDate, mass)

siteId1 <- generateObservationID()
siteId2 <- generateObservationID()

tidy2NFsiteLevel <- messy2NF %>%
  select(site, canopyCover) %>%
  distinct %>%
  transmute(id = c(siteId1, siteId2), site, canopyCover)

# 3NF: 

messy3NF1 <- exampleTidy1 %>%
  mutate(yearBanded = c(2016, 2015, 2016, 2016, 2016))

exampleTidy1

# Putting it all together (exercise):

exercise1messy <- messy2NF %>%
  mutate(
    hTemp = c(22.2, 22.2, 26.8, 31.0, 18.7),
    siteXY = case_when(
      site == 'apple' ~ '-77.048, 38.925',
      site == 'avocado' ~ '-77.053, 38.929'
    ),
    species = case_when(
      birdID %in% c('1123-58132', '1123-58133') ~ 'NOCA',
      birdID %in% '1123-58134' ~ 'GRCA'
    )
  ) %>%
  rename(date = observationDate, canopy = canopyCover, spp = species)

# also ----

gitSite <- 'https://raw.githubusercontent.com/bsevansunc/rWorkshop/master/'

dirtyBirdURL <- getURL(paste0(gitSite, 'dirtyBirdData','.csv'))

dirtyBandingURL <- getURL(paste0(gitSite, 'dirtyBandingData','.csv'))

dirtyResightURL <- getURL(paste0(gitSite, 'dirtyResightData','.csv'))

dirtyBird <- read_csv(dirtyBirdURL)

dirtyBanding <- read_csv(dirtyBandingURL)

dirtyResight <- read_csv(dirtyResightURL)

dfWide <- data.frame(
  subject = c('A', 'B', 'C'),
  mass2016 = c(13.2, 14.6, 27.1),
  mass2017 = c(26.4, 15.2, 31.3)
)

dfLong <- dfWide %>%
  gather(key = year,
         value = value,
         mass2016:mass2017) %>%
  mutate(year = str_replace_all(year, 'mass', ''))






