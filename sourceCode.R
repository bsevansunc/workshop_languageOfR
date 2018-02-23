#=================================================================================*
# ---- functions ----
#=================================================================================*

# Function searches packages in installed package list, adds them if you don't
# have them, and loads the library:

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

library(lubridate)

rename <- dplyr::rename

select <- dplyr::select

# Provide the file read location:

url <- 'https://raw.githubusercontent.com/bsevansunc/workshop_languageOfR/master'

#=================================================================================*
# ---- vectors ----
#=================================================================================*

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

#=================================================================================*
# ---- data frames ----
#=================================================================================*

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

#---------------------------------------------------------------------------------*
# ---- lesson 4 ----
#---------------------------------------------------------------------------------*

# Motor trend car facts:

motorTrend <- mtcars %>%
  mutate(model = rownames(mtcars)) %>%
  slice(-c(2, 4, 6, 26, 27, 29)) %>%
  separate(model, sep = ' ', into = c('make', 'model')) %>%
  arrange(make, model) %>%
  select(make, model, mpg:carb)

# States in 1975:

states1975 <- data_frame(
  region = state.region,
  division = state.division,
  state = state.name,
  area = state.area,
  population = state.x77[, 'Population']
)

# World Health Organization's population dataset:


whoPopulation <- population

# Star wars!

measurements <- starwars %>%
  select(name, height, mass) %>%
  filter(!is.na(mass))

origins <- starwars %>%
  select(name, homeworld, species) %>%
  filter(name %in% measurements$name)

#---------------------------------------------------------------------------------*
# ---- lesson 5 ----
#---------------------------------------------------------------------------------*

generateObservationID <- function(){
  n1 <- sample(100:999,1)
  l1 <- sample(letters,1)
  n2 <- sample(1000:9999, 1)
  l2 <- sample(letters, 1)
  paste0(l1, n1, '-', n2, l2)
}

obs <- vector('character', length = 5)

birdIds <- c('1123-58132', '1123-58133', '1123-58134')

for(i in seq_along(obs)){
  obs[i] <- generateObservationID()
} 

# 1st normalization rule, Each row is an observation:

messy1NFa <- data.frame(
  id = obs[1],
  birdID = '1123-58132',
  observationDate = '2016-05-16',
  measurement = c('mass', 'wing', 'tail'),
  value = c(34.5, 96.7, 107)
)

# 1st normalization rule, Each row is an observation, fixed:

tidy1NFa <- messy1NFa %>% 
  spread(measurement, value)

# 1st normalization rule, All values are atomic

badDate <-
  data.frame(
    birdID = c('1123-58132', '1123-58133', '1123-58134'),
    observationDate = c(
      '2016-05-16, 2017-07-12',
      '2016-05-26',
      '2016-06-02, 2017-05-12'
    )
  )

# 1st normalization rule, All values are atomic, fixed but breaks part a:

tidy1NFb0 <- badDate %>% 
  separate(observationDate, into = c('date1', 'date2'), sep = ', ')

# 1st normalization rule, All values are atomic, fixed:

tidy1NFb <- tidy1NFb0 %>%
  gather(tmp, date, date1:date2, -birdID, na.rm = TRUE) %>%
  select(-tmp)

# 1st normalization rule, No repeated groupings of columns:

messy1NFc <- tidy1NFb0 %>%
  rename(observationDate1 = date1, observationDate2 = date2) %>%
  mutate(
    mass1 = c(34.5, 35.7, 38.0),
    mass2 = c(36.2, NA, 37.6)
  )

# 1st normalization rule, No repeated groupings of columns, fixed:

exampleTidy1 <- data.frame(
  id = obs,
  birdID = c(birdIds[1:3], birdIds[1],birdIds[3]),
  observationDate = c('2016-05-16','2016-05-16','2016-06-02','2017-07-12','2017-05-12'),
  mass = c(34.5,35.7,38.0,36.2,37.6)
)

# 2nd normalization rule, All columns are unique to the primary key:

messy2NF <- exampleTidy1 %>%
  mutate(
    site = c('apple','apple', 'avocado', 'apple', 'avocado'),
    canopyCover = c(32.5, 32.5, 78.4, 32.5, 78.4)
  ) %>%
  select(id, birdID, observationDate, site, canopyCover, mass)

# 2nd normalization rule, All columns are unique to the primary key, fixed:

siteIds <- vector('character', length = 2)

for(i in seq_along(siteIds)){
  siteIds[i] <- generateObservationID()
}

# 2nd normalization rule, fixed table 1 (bird observation level): 

tidy2NFobsLevel <- messy2NF %>%
  select(id, birdID, site, observationDate, mass)

# 2nd normalization rule, fixed table 2 (site level): 

tidy2NFsiteLevel <- messy2NF %>%
  select(site, canopyCover) %>%
  distinct %>%
  transmute(id = c(siteIds[1], siteIds[2]), site, canopyCover)

# 3rd normalization rule, All columns are non-transitive:

badYear <- exampleTidy1 %>%
  mutate(observationYear = lubridate::year(observationDate))

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

# Data frames for reshaping data:

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

dfTooLong <- data.frame(
  id = obs[1],
  birdID = rep('1123-58132', 3),
  observationDate = rep('2016-05-16', 3),
  measurement = c('mass', 'wing', 'tail'),
  value = c(34.5, 96.7, 107)
)

messyBander <- exampleTidy1 %>%
  mutate(
    site = c('apple','apple', 'avocado', 'apple', 'avocado'),
    canopyCover = c(32.5, 32.5, 78.4, 32.5, 78.4)
  ) %>%
  select(id, birdID, observationDate, site, canopyCover, mass)

someMessyData <- exercise1messy %>%
  select(-hTemp) %>%
  slice(-5)

#---------------------------------------------------------------------------------*
# ---- lesson 5, homework ----
#---------------------------------------------------------------------------------*

# gitSite <- 'https://raw.githubusercontent.com/bsevansunc/rWorkshop/master/'

# dirtyBirdURL <- getURL(paste0(gitSite, 'dirtyBirdData','.csv'))
# 
# dirtyBandingURL <- getURL(paste0(gitSite, 'dirtyBandingData','.csv'))
# 
# dirtyResightURL <- getURL(paste0(gitSite, 'dirtyResightData','.csv'))
# 
# dirtyBird <- read_csv(dirtyBirdURL)
# 
# dirtyBanding <- read_csv(dirtyBandingURL)
# 
# dirtyResight <- read_csv(dirtyResightURL)
# 
# pointCounts <- left_join(birdCounts, birdHabits, by = 'species') %>%
#   mutate(foragingClass = paste(foraging, diet, sep = '_')) %>%
#   select(site, species, foragingClass, count) %>%
#   rowwise() %>%
#   mutate(date = sample(1:2, 1))

untidyFrame <- data.frame(subject = c('A','B','C'), 
                          treatmentA = c(1.3, 2.3, 3.1), 
                          treatmentB = c(2.9, 3.2, 4.6))

wideFrame <- data.frame(species = c('amro', 'carw', 'grca'),
                        d10 = c(0,0,1),
                        d20 = c(1,1,0), 
                        d30 = c(0,0,0))

longFrame <- data.frame(site = c('site1', 'site2' ,'site2',rep('site3',3)),
                        species = c('amro', c('carw','grca'), 'amro','carw','grca'),
                        count = c(1,1,2, 5, 1, 2))

badBandingRecord <- exampleTidy1 %>%
  mutate(
    site = c('apple','apple', 'avocado', 'apple', 'avocado'),
    canopyCover = c(32.5, 32.5, 78.4, 32.5, 78.4)
  ) %>%
  select(id, birdID, observationDate, site, canopyCover, mass)

#=================================================================================*
# ---- other object classes ----
#=================================================================================*

# Example matrix objects:

m <- matrix(fibFun(c(1,1), 6), ncol = 2)

exampleMatrix <- sample(1:5, 60, replace = TRUE) %>%
  matrix(ncol = 3, byrow = TRUE)

# Add a treatment vector the matrix after converting to a data frame:

treatmentVector <- sample(letters[1:2], 10, replace = TRUE)

options(stringsAsFactors = FALSE)





