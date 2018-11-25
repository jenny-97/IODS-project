hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

#exploring the structures and dimensions of the datasets
str(hd)
dim(hd)
str(gii)
dim(gii)
summary(hd)
summary(gii)

#renaming the variables
names(hd)
names(hd) <- c("HDI", "country", "hum.dev", "life.exp", "exp.edu", "mean.edu", "GNI", "GNI-HDI")
names(gii)
names(gii) <- c("GII.rank", "country", "GII", "mat.mort", "ado.birth", "rep.par", "eduF","eduM", "partF","partM")
names(gii)

#creating new variables 
gii <- mutate(gii, eduFMratio = (eduF / eduM))
gii <- mutate(gii, labFMratio = (partF/partM))

#joining together the datasets
human <- inner_join(hd, gii, by = "country")
dim(human)
