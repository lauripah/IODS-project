setwd("~/IODS/IODS-project/data")

hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

#Structures, dimensions and summaries
str(hd)
str(gii)

dim(hd)
dim(gii)

summary(hd)
summary(gii)

#Renaming the columns
hd_names <- c("HDI_rank", "country", "HDI", "life_exp", "education","education_mean", "GNI", "GNI_rank")
gii_names <- c("GII_rank", "country", "GII", "maternal_death", "adolescent_birth", "female_parliament","education_F", "education_M", "labour_F", "labour_M" )

names(hd) <- hd_names
names(hd)

names(gii) <- gii_names
names(gii)

#Creating the new variables
edu_ratio<-gii$education_F / gii$education_M

lab_ratio <- gii$labour_F / gii$labour_M

gii$edu_ratio <- edu_ratio
gii$lab_ratio <- lab_ratio

#Combining the datasets

install.packages("dplyr")
library(dplyr)

human <- inner_join(gii, hd, by = "country")

glimpse(human)

#Saving the combined data as human.csv
write.csv(human, "human.csv")