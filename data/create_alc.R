#Lauri-Pekka Aho
#10.2.2017
#Data wrangling of UCI Machine Learning Repository, Student Alcohol consumption data

setwd("~/IODS/IODS-project/data")

math <- read.csv("student-mat.csv", sep = ";")
str(math)
dim(math)

por <- read.csv("student-por.csv", sep = ";")
str(por)
dim(por)

install.packages("dplyr")
library(dplyr)

join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")

math_por <- inner_join(math, por, by = join_by, suffix=c(".math", ".por"))
str(math_por)
dim(math_por)

alc <- select(math_por, one_of(join_by))

notjoined_columns <- colnames(math)[!colnames(math) %in% join_by]

notjoined_columns

for(column_name in notjoined_columns) {
  two_columns <- select(math_por, starts_with(column_name))
  first_column <- select(two_columns, 1)[[1]]
  if(is.numeric(first_column)) {

    alc[column_name] <- round(rowMeans(two_columns))
  } else {
    alc[column_name] <- select(two_columns, 1)[[1]]
  }
}

alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

alc <- mutate(alc, high_use = (alc_use > 2))

glimpse(alc)

write.csv(alc, "alc.csv")