# R worksheet script, lessons 1-4

library(RCurl)

script <- getURL("https://raw.githubusercontent.com/bsevansunc/workshop_languageOfR/master/sourceCode.R")

eval(parse(text = script))

rm(script)


