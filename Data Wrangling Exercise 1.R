#setup
getwd()
setwd("/Users/monicaseeley/Documents/R Files")
library(dplyr)
library(tidyr)
library(readr)
electronics <- read_csv("refine_original.csv")
View(electronics)

#spelling correction of "company" column
electronics$company[electronics$company == "akzo"] <- "AKZO7"
electronics$company[electronics$company == "ak zo"] <- "AKZO7"
electronics$company[electronics$company == "Akzo"] <- "AKZO7"
electronics$company[electronics$company == "AKZO"] <- "AKZO7"
electronics$company[electronics$company == "fillips"] <- "phillips"
electronics$company[electronics$company == "philips"] <- "phillips"
electronics$company[electronics$company == "phillipS"] <- "phillips"
electronics$company[electronics$company == "Phillips"] <- "phillips"
electronics$company[electronics$company == "phlips"] <- "phillips"
electronics$company[electronics$company == "Phillps"] <- "phillips"
electronics$company[electronics$company == "Phllps"] <- "phillips"
electronics$company[electronics$company == "Unilever"] <- "unilever"
electronics$company[electronics$company == "unilver"] <- "unilever"
electronics$company[electronics$company == "Van Houten"] <- "van houten"
electronics$company[electronics$company == "Van Houten"] <- "van houten"
electronics$company[electronics$company == "van Houten"] <- "van houten"

electronics$company[electronics$company == "akzO"] <- "AKZO7"
electronics$company[electronics$company == "akz0"] <- "AKZO7"
electronics$company[electronics$company == "phllips"] <- "phillips"
View(electronics)
electronics$company[electronics$company == "phillps"] <- "phillips"

#seperate "Product code / number" column into "product code" and "product number:
electronics <- separate(electronics, "Product code / number", c("product_code", "product_number"), sep = "-")

#create "product" column
electronics <- electronics %>% mutate(products = product_code)

#correct "product column to "smartphone, laptop, TV, tablet"

electronics$products[electronics$products == "p"] <- "smartphone"
electronics$products[electronics$products == "x"] <- "laptop"
electronics$products[electronics$products == "v"] <- "TV"
electronics$products[electronics$products == "q"] <- "tablet"

#create "full_address" from "address, city, country"
electronics <- unite_(electronics, "full_address", c("address", "city", "country"), sep = ",", remove = FALSE)

#create dummy variables, binary columns for "company_phillips, company_akzo, company_van_houten, company_unilever"
electronics <- electronics %>% mutate(company_phillips = (ifelse(electronics$company == "phillips", 1, 0)))
electronics <- electronics %>% mutate(company_akzo = (ifelse(electronics$company == "AKZO7", 1, 0)))
electronics <- electronics %>% mutate(company_van_houten = (ifelse(electronics$company == "van houten", 1, 0)))
electronics <- electronics %>% mutate(company_unilever = (ifelse(electronics$company == "unilever", 1, 0)))

#create dummy varialbes, binary columns for "product_smartphone, product_TV, product_laptop, product_tablet"
electronics <- electronics %>% mutate(product_smartphone = (ifelse(electronics$products == "smartphone", 1, 0)))
electronics <- electronics %>% mutate(product_TV = (ifelse(electronics$products == "TV", 1, 0)))
electronics <- electronics %>% mutate(product_laptop = (ifelse(electronics$products == "laptop", 1, 0)))
electronics <- electronics %>% mutate(product_tablet = (ifelse(electronics$products == "tablet", 1, 0)))

#turn "electronics" dataframe into "refine.clean.csv"
write.csv(x = electronics, file = "refine.clean.csv", row.names = FALSE)
