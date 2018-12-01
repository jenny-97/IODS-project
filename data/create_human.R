#creating a new file even though I did the data wrangling.. It's easier to work if the variables are the same as in datacamp and the instructions
#Jenny Österlund
#original files: http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv, http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv
#1.12.2018
human <- read.table("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human1.txt", sep = ",", header = TRUE)
str(human)
dim(human)
names(human)
#The human dataset describes the variables that affect HDI. HDI (human development index) is a measurement for how developed a country is based on the people that live there and their circumstances. This dataset has been modified so that data from different countries is combined as indicators. Indicators of helath and knowledge are "GNI" = Gross Nationl Income per capita, "Life.Exp" = Life expectancy at birth, "Edu.Exp" = Expected years of schooling, "Mat.Mor" = Maternal mortality ratio and "Ado.Birth" = Adolescent birth rate. Indicators of empowerment are "Parli.F" = Percetange of female representatives in parliament, "Edu2.F" = Proportion of females with at least secondary education, "Edu2.M" = Proportion of males with at least secondary education, "Labo.F" = Proportion of females in the labour force and "Labo.M" = Proportion of males in the labour force. "Edu2.F" and "Edu2.M"has been combined into "Edu2.FM". this indicator describes the ratio between the genders' education. "Labo2.F" and "Labo2.M" has also been combined into "Labo2.FM". this indicator describes the ratio between the genders in thelabour force.

#mutating the data: transforming GNI to numeric
library(stringr)
str_replace(human$GNI, pattern=",", replace ="") %>% as.numeric$GNI
human$GNI <- as.numeric(human$GNI)
human$GNI

#excluding unneeded variables and deleting rows with missing values(NA)
keep <- c("Country", "Edu2.FM", "Labo.FM", "Life.Exp", "Edu.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")
human <- dplyr::select(human, one_of(keep))
complete.cases(human)
data.frame(human[-1], comp = complete.cases(human))
human <- filter(human, complete.cases(human))
dim(human)

#removing observations related to regions instead of countries 

tail(human, n=10)
   #from this we see that the last 7 observations are related to regions
last <- nrow(human) - 7
human <- human[1:last,]

#defining row names byt the countries and removing the country name column from the data.
rownames(human) <- human$Country
human <- dplyr::select(human, -Country)
dim(human)
#the data now contains 155obs. and 8 vari.

#saving the data
write.csv(human, file = "create_human.csv", row.names = TRUE) 
