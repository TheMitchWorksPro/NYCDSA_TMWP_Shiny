## global.R ##
##############################################
###      Data Science Bootcamp 10          ###
###  Project 1 - Exploratory Visualization ###
###     Mitch Abramson  / July 2017        ###
###       Analysis of IMDB Data            ###
###     For What Writers Care About        ###
##############################################

# v 1.1
# v1 published on shiny.io under this app name: TMWP Shiny App - IMDB
#    this url:  https://themitchworkspro.shinyapps.io/tmwp_shiny_app_-_imdb/

# library(stringi)
# library(stringr)

library(dplyr)
library(tidyr)
library(data.table)
library(DT)
library(shiny)
library(rsconnect)

# getwd() setwd("/Users/mitchmac/Documents/DS_BootCamp/projects/shiny_imdb/")

dataDir <- "./data_srv/"
grfxDir <- "./img/"

appImages <- c("https://yt3.ggpht.com/-04uuTMHfDz4/AAAAAAAAAAI/AAAAAAAAAAA/Kjeupp-eNNg/s100-c-k-no-rj-c0xffffff/photo.jpg", 
               "IMDB_2017ReleasesPage.png",
               "MoviesIcon.png",
               "movies_splashImage3.jpg") 

# legend:
#  * 1 = NYC DSA Logo
#  * 2 = IMDB 2017 Releases Page image
#  * 3 = Movie Slate Icon
#  * 4 = Movies dark lightning banner

appHyperLnks <- c("https://data.world/studentoflife/imdb-top-250-lists-and-5000-or-so-data-records",
                  "tbd")

# source data
appSrcDatFiles <- c("IMDBdata_hotlist2.csv",
                    "IMDBdata_Main_Hflds.csv")
# dataframes
IMDB_topLsts <- fread("./data_srv/IMDBdata_hotlist2.csv", na.strings=c(""," ","NA"))

# clean a mistake during data preparation (need these values a bit differently to control display):
IMDB_topLsts <- IMDB_topLsts %>% 
       mutate(., Record = ifelse(Record == "Bottom 250 Movies", "100 Bottom Movies", Record)) %>%
       mutate(., Record = ifelse(Record == "Top 250 Movies", "250 Top Movies", Record)) %>%
       mutate(., Record = ifelse(Record == "Top 250 Eng Movies", "250 Top Eng Movies", Record)) %>%
       mutate(., Record = ifelse(Record == "Top 250 Indian Movies", "250 Top Indian Movies", Record))
                       
IMDB_Main_tl_flds <- fread(paste0(dataDir, "IMDBdata_Main_Hflds.csv"), na.strings=c(""," ","NA"))
IMDB_AllData <- union(IMDB_topLsts, IMDB_Main_tl_flds)

dataChoices <- c(unique(IMDB_topLsts$Record), IMDB_Main_tl_flds$Record[1])
  # assert: this generates 4 values from first table and one more from second table

colorChoices <- c("cyan", "blue", "purple", "magenta", "red", "orange", "yellow", "darkgreen", "green", "grey", "darkgrey", "brown")



