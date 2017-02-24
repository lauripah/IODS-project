# Chapter 4 & 5
# Lauri-Pekka Aho
# 24.2.2017
# Dimensionality reduction techniques

setwd("~/IODS/IODS-project/data")

hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

# Structures, dimensions and summaries
str(hd)
str(gii)

dim(hd)
dim(gii)

summary(hd)
summary(gii)

# Renaming the columns
hd_names <- c("HDI_rank", "country", "HDI", "life_exp", "education","education_mean", "GNI", "GNI_rank")
gii_names <- c("GII_rank", "country", "GII", "maternal_death", "adolescent_birth", "female_parliament","education_F", "education_M", "labour_F", "labour_M" )

names(hd) <- hd_names
names(hd)

names(gii) <- gii_names
names(gii)

# Creating the new variables
edu_ratio<-gii$education_F / gii$education_M

lab_ratio <- gii$labour_F / gii$labour_M

gii$edu_ratio <- edu_ratio
gii$lab_ratio <- lab_ratio

# Combining the datasets

install.packages("dplyr")
library(dplyr)

human <- inner_join(gii, hd, by = "country")

glimpse(human)
dim(human)
# Saving the combined data as human.csv
write.csv(human, "human.csv")

#####################################################################

# Chapter 5

# I downloaded the data from Internet because I saw some mistakes in my last weeks data

human <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human1.txt",stringsAsFactors = F)

# Installing the stringr-package
install.packages("stringr")
library(stringr)

# Looking at the class of GNI-variable
class(human$GNI)
str(human$GNI)

# Mutating to numeric
human$GNI <- str_replace(human$GNI, pattern=",", replace ="") %>% as.numeric
str(human$GNI)

# Columns to keep and exclude
keep <- c("Country", "Edu2.FM", "Labo.FM", "Life.Exp", "Edu.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")
human <- select(human, one_of(keep))

# Removing rows with missing values
data.frame(human[-1], comp = complete.cases(human))
human <- filter(human, complete.cases(human))

# Removing regions
to_remove <- c("East Asia and the Pacific", "Europe and Central Asia", "Arab States", "Latin America and the Caribbean", "Sub-Saharan Africa", "World", "South Asia")
human <- subset(human, ! Country %in% to_remove)

# Removing Country-variable

rownames(human) <- human$Country
human<- select(human, -Country)

# Saving as human.csv
write.csv(human, "human.csv", row.names=TRUE)
