library("dplyr")
library(ggplot2)
library(hrbrthemes)


covid19_data <- read.csv("https://raw.githubusercontent.com/info201b-au2022/project-selmalink/main/data/mask-use-by-county.csv")

covid <- covid19_data

ggplot(covid, aes(x=COUNTYFP, y=NEVER)) + 
  geom_point(size=0.5) + theme_ipsum()

ggplot(covid, aes(x=COUNTYFP, y=RARELY)) + 
  geom_point(size=0.5) + theme_ipsum()
 
ggplot(covid, aes(x=COUNTYFP, y=SOMETIMES)) + 
  geom_point(size=0.5) + theme_ipsum()
 
ggplot(covid, aes(x=COUNTYFP, y=FREQUENTLY)) + 
  geom_point(size=0.5) + theme_ipsum()

ggplot(covid, aes(x=COUNTYFP, y=ALWAYS)) + 
  geom_point(size=0.5) + theme_ipsum()

