# R worksheet script, lessons 1-4

#=================================================================================*
# ---- set-up ----
#=================================================================================*

# Load RCurl library (allows you to read online data and code to be read):

library(RCurl)

# Note: If you have not yet installed RCurl, please use the following to do so:
# install.packages(RCurl)

# Load a script that provides source code, automatically reading in data
# associated with this worksheet:

script <-
  getURL(
    "https://raw.githubusercontent.com/bsevansunc/workshop_languageOfR/master/sourceCode.R"
  )

# Evaluate the source code and then remove the file from your working environment:

eval(parse(text = script))

rm(script)

# For the following questions, please write your code where prompted. Unless
# specified otherwise:
# - DO NOT assign a name to any object
# - Complete each step with ONE LINE of code

#---------------------------------------------------------------------------------*
# ---- Question 1 ----
#---------------------------------------------------------------------------------*

# For this question, you will use a preloaded vector object named "monthFactor".
# Please take a moment to explore this object:

monthFactor

# 1.a Modify monthFactor such that the levels are provided in date order and the
# first letter of each label is capitalized. Assign the name "month" to the
# resultant object:



# 1.b Convert the "month" vector to a character vector and assign the name 
# "monthChar" to the resultant object:



# 1.c Use indexing to extract the fourth and seventh value of monthChar:



# 1.d In one line of code, calculate the number of values in monthChar for which
# the month is February OR March:



# 1.e Extract a vector of unique values of monthChar:



# 1.f The code below is an incomplete function that counts the number of values
# in a vector that contain a given letter, 'x', as its last letter. Complete this
# function and test by calculating the number of values in monthChar that end in
# the letter "y".

lastLetterSum <- function(vectorIn, x){
  lastLetter <- str_sub(# COMPLETE
  nLastLetter <- # COMPLETE
  return(nLastLetter)
}

#---------------------------------------------------------------------------------*
# ---- Question 2 ----
#---------------------------------------------------------------------------------*

# For this question, you will use a preloaded matrix object named "exampleMatrix".
# Please take a moment to explore this object:

exampleMatrix

# 2.a Subset exampleMatrix to columns 1 and 3 and rows 1-10. Assign the name 
# exampleMatSub to the resultant object:



# 2.b Convert exampleMatSub to a data frame. Name the resultant object exampleDf:



# 2.c Rename the columns of the data frame "pre" and "post":



# 2.d The following vector, "treatmentVector", contains two treatment levels, "a"
# and "b". Add treatmentVector to exampleDf and name the new column treatment:

treatmentVector


# 2.e Re-arrange the columns such that "treatment" is the first column, "pre"
# is the second column, and "post" is the third column. Name the resultant
# object "exampleDf2":



# 2.f Calculate the positions (row numbers) for which the pre value is equal to 5:



# 2.g Using the object exampleDf2, calculate the mean of pre values for
# treatment "b":



#---------------------------------------------------------------------------------*
# ---- Question 3 ----
#---------------------------------------------------------------------------------*

# For this question, you will use a preloaded data frame object named 
# "population". Please take a moment to explore this object:

population

# 3.a Assign the name "whoPopulation" to the "population" data frame:



# 3.b Subset whoPopulation to only countries that include the word
# "State" in their names:



# 3.c Repeat 3.a above and extract a vector of unique country names:



# 3.d Subset whoPopulation to the countries Jamaica, Bahamas, Cuba:



# 3.e The code below is an incomplete function that is intended to allow users
# to calculate the population of a given country on a given year. Complete the
# function and use it to calculate the population of the Bahamas in 2012:

popCountryYear <- function(country, yr){
  whoCountrySubset <- whoPopulation[# COMPLETE
  whoYrSubset <- whoCountrySubset[ # COMPLETE
  return( # COMPLETE
}

#---------------------------------------------------------------------------------*
# ---- Question 4 ----
#---------------------------------------------------------------------------------*

# For this question, you will use the "birdCounts" and "birdHabits" data frames. 
# Please take a moment to explore these objects:

birdCounts

birdHabits

# 4.a Using the "birdCounts" data frame, extract a unique vector of sites:



# 4.b Using the "birdCounts" data frame, extract the first five values of 
# unique site names:



# 4.c Using the "birdHabits" data frame, extract a unique vector of species that 
# are insectivores:



# 4.d Using the "birdCounts" data frame, extract a unique vector of sites:



# 4.e The code below is an incomplete function that is intended to allow users
# to extract a unique vector of species for some diet class. Complete the
# function and use it to extract a unique vector of insectivores:

sppDietClass <- function(dfIn, dietClass){
  unique(dfIn$diet # COMPLETE
}

# 4.f Use the function you created in 4.e to subset birdCounts to just 
# insectivore observations:



# 4.g The code below is an incomplete function that is intended to allow users
# to subset a data frame to a given diet class (as 4.f above). Complete
# this function and use it to subset birdCounts to just insectivore 
# observations:

dietCountSubset <- function(dfIn, dietClass){
  dfIn[dfIn$species # COMPLETE
}

# 4.h The code below is an incomplete function that is intended to allow users
# to sum the total count of a given diet class for a given site. The
# function will return a one-row data frame with the columns, "dietClass", "site",
# and "count". Complete the function and use it to calculate the 
# number of insectivores at the site "apricot":


dietSiteSum <- function(dfIn, dietClass, site){
  dietClassSubset <- dietCountSubset(dfIn, dietClass)
  siteSubset <- dietClassSubset[# COMPLETE
  sumCount <- sum(siteSubset$ # COMPLETE
  outFrame <- data_frame(site = site, count = # COMPLETE
  return( # COMPLETE
}

#---------------------------------------------------------------------------------*
# ---- Question 5 ----
#---------------------------------------------------------------------------------*

# For this question, you will use the "birdRichness" data frame. Please take a 
# moment to explore this object:

birdRichness

# The species-area relationship of Arrhenius (1921) states that the number of 
# species (S) is dependent on the rate of increase in species with increasing area
# (z) multiplied by a constant (c) that represents the number of species that 
# would be present in one spatial unit. (See worksheet for formula)

# 5.a Convert the species-area relationship formula to an R function, with c, A, 
# and z set as unknowns:



# 5.b Using 15 for the value of c and a z of 0.75 and your function above,
# calculate the expected species richness at the first three sites in the 
# birdRichness data frame (Note: calculate the richness at each site in a 
# separate line of code):



#---------------------------------------------------------------------------------*
# ---- Question 6 ----
#---------------------------------------------------------------------------------*

# The exponential population growth model describes the growth of a population
# without resource limitations. This model describes the size of a population 
# at a given time unit as a function of the per capita growth rate of the 
# population (r) and the size of the population at time t. (See worksheet for 
# formula)

# 6.a Convert the exponential population growth model to an R function with r,
# the initial population size, and t as unknowns:



# 6.b With an initial population size of 25 and a per capita growth rate (r) of 
# 0.45, use the exponential population growth rate function to calculate the size
# of the population after 2, 5, and 10 generations (Note: calculate the population
# size of each generation as separate lines of code):



#---------------------------------------------------------------------------------*
# ---- Question 7 ----
#---------------------------------------------------------------------------------*

# The logistic population growth model (Verhulst) states that the growth of the .
# population will be constrained by the population carrying capacity (K) as a 
# function of resource limitations. (See worksheet for formula)

# 7.a Convert the logistic population growth model to an R function with r, 
# the initial population size, t, and K as unknowns:



# 7.b With an initial population size of 25, a per capita growth rate (r of 0.45,
# and a carrying capacity of 500 individuals, use the logistic population growth
# rate function and a  for loop to calculate the size of the population after
# 2, 5, and 10 generations (Note: calculate the population
# size of each generation as separate lines of code):


