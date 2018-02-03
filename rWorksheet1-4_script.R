# R worksheet script, lessons 1-4

#=================================================================================*
# ---- set-up ----
#=================================================================================*

# Load RCurl library (allows you to read online data and code to be read):

library(RCurl)

# Load a script that provides source code, automatically reading in data
# associated with this worksheet:

script <-
  getURL(
    "https://raw.githubusercontent.com/bsevansunc/workshop_languageOfR/master/sourceCode.R"
  )

# Evaluate the source code and then remove the file from your working environment:

eval(parse(text = script))

rm(script)

#---------------------------------------------------------------------------------*
# ---- Question 1 ----
#---------------------------------------------------------------------------------*

# Explore the vector "monthFactor":

monthFactor

# 1.1 Modify monthFactor such that the levels are provided in date order:



# 1.2 Modify the labels of monthFactor such that the first letter of each label is
# capitalized:



# 1.3 Convert monthFactor to a character vector:



#---------------------------------------------------------------------------------*
# ---- Question 2 ----
#---------------------------------------------------------------------------------*

