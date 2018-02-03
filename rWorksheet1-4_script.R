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

# 1.1 Modify monthFactor such that the levels are provided in date order and the
# first letter of each label is capitalized. Assign the name "month" to the
# resultant object:



# 1.2 Convert the "month" vector to a character vector and assign the name 
# monthChar to the resultant object:



# 1.3 In one line of code, calculate the number of records for which the month is
# February OR March:



#---------------------------------------------------------------------------------*
# ---- Question 2 ----
#---------------------------------------------------------------------------------*

# For this question, you will use a preloaded matrix object named "exampleMatrix".
# Please take a moment to explore this object:

exampleMatrix

# 2.1 Subset exampleMatrix to columns 1 and 3 and rows 1-10. Assign the name 
# exampleMatSub to the resultant object:

exampleMatSub <- exampleMatrix[1:10, c(1,3)]

# 2.2 Convert exampleMatSub to a data frame. Name the resultant object exampleDf:

exampleDf <- as.data.frame(exampleMatSub)

# 2.3 Rename the columns of the data frame "pre" and "post":

names(exampleDf) <- c('pre', 'post')

# 2.4 The following vector, "treatmentVector", contains two treatment levels, "a"
# and "b". Add treatmentVector to exampleDf and name the new column treatment:

treatmentVector

exampleDf$treatment <- treatmentVector

# 2.5 Re-arrange the columns such that "treatment" is the first column, "pre"
# is the second column, and "post" is the third column. Name the resultant
# object "exampleDf2":

exampleDf2 <- exampleDf[, c(3,1:2)]

# 2.6 Using the object exampleDf2, calculate the mean of pre values for
# treatment "b":

mean(exampleDf2[exampleDf2$treatment == 'b', 'pre'])

#---------------------------------------------------------------------------------*
# ---- Question 3 ----
#---------------------------------------------------------------------------------*









