##Lauri-Pekka Aho
##3.2.2017
##I created a new file.

install.packages("dplyr")

lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

library(dplyr)

deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

deep_columns <- select(lrn14, one_of(deep_questions))
lrn14$deep <- rowMeans(deep_columns)

surface_columns <- select(lrn14, one_of(surface_questions))
lrn14$surf <- rowMeans(surface_columns)

strategic_columns <- select(lrn14, one_of(strategic_questions))
lrn14$stra <- rowMeans(strategic_columns)

learning2014 <- select(lrn14,one_of(c("gender","Age","Attitude", "deep", "stra", "surf", "Points")))

colnames(learning2014)[2] <- "age"
colnames(learning2014)[3] <- "attitude"
colnames(learning2014)[7] <- "points"

learning2014$attitude <- learning2014$attitude / 10

learning2014 <- filter(learning2014,points>0 )

setwd("~/IODS/IODS-project/data")


write.table(learning2014, file = "learning2014.txt")

test<-read.table("learning2014.txt")

str(test)
head(test)

