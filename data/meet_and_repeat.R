#Jenny Österlund, 5.12.2018

#reading in the BPRS dataset and exploring its structure and variables
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep  =" ", header = T)
names(BPRS)
str(BPRS)
dim(BPRS)
summary(BPRS)
glimpse(BPRS)
library(dplyr)
library(tidyr)

# Factor treatment & subject
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)

# Convert to long form
BPRSL <-  BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject)

# Extract the week number
BPRSL <-  BPRSL %>% mutate(week = as.integer(substr(weeks,5,5)))

#exploring the structure of the modified BPRS (=BPRSL)
names(BPRSL)
str(BPRSL)
dim(BPRSL)
summary(BPRSL)
glimpse(BPRSL)
#reading in the RATS dataset and exploring its structure and variables
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header = TRUE, sep = '\t')
names(RATS)
str(RATS)
dim(RATS)
summary(RATS)
glimpse(RATS)

# Factor ID and Group
RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)

# Convert to long form and extract day numbers from WD
RATSL <- RATS %>% gather(key = WD, value = Weight, -ID, -Group) %>% mutate(Time = as.integer(substr(WD, 3,4))) 
names(RATSL)
str(RATSL)
dim(RATSL)
summary(RATSL)
glimpse(RATSL)

#The major difference I noticed between wide and long data is that in wide data form the responses from one subject ispresented in one row, and each response has a separate column.In the long form, each row represents one response-time per subject. Each row has data from all the subjects. Therefore, only one column per variable (such as WD)is needed.