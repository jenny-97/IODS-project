Jenny Österlund, 17.11.2018, the assignment for week 3
install.packages("dplyr")
library(foreign)
library(dplyr)

#reading in the data and exploring it's dimensions and structure

url1 <- ("/Users/Jenny/OneDrive/Dokument/GitHub/IODS-project/data")
url2 <- ("/Users/Jenny/OneDrive/Dokument/GitHub/IODS-project/data")
url_math<- paste(url1, "student-mat.csv", sep = "/")
url_por<- paste(url1, "student-por.csv", sep = "/")
math <- read.table(url_math, sep = ";", header = TRUE)
por <- read.table(url_por, sep = ";", header = TRUE)
dim(math)
dim(por)
str(math)
str(por)

#joining the datasets by common identifiers and exploring the joined dataset's dimension and structure
join_by <- c("school", "sex", "age", "address", "famsize", "Pstatus", "Medu", "Fedu", "Mjob", "Fjob", "reason", "nursery","internet")
#my join_by doesn't work for some reason.. 
math_por <- inner_join(math, por, by = c("school", "sex", "age", "address", "famsize", "Pstatus", "Medu", "Fedu", "Mjob", "Fjob", "reason", "nursery","internet"), suffix=c(".math", ".por"))
dim(math_por)
str(math_por)

#new dataset with the joined columns only

alc <- select(math_por, one_of(join_by))

# the columns in the datasets which were not used for joining the data
notjoined_columns <- colnames(math)[!colnames(math) %in% join_by]

# print out the columns not used for joining
print(notjoined_columns)

# for every column name not used for joining...
for(column_name in notjoined_columns) {
  # select two columns from 'math_por' with the same original name
  two_columns <- select(math_por, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- first_column
  }
}

# glimpse at the new combined data
glimpse(alc)

#alcohol consumption calculation
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

#new logical high alchol useage column
alc <- mutate(alc, high_use = alc_use > 2)
glimpse(alc)

#saving the data
write.table(alc) 
