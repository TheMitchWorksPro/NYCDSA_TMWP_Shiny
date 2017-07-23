## content module for R ##
##############################################
###      Data Science Bootcamp 10          ###
###  Project 1 - Exploratory Visualization ###
###     Mitch Abramson  / July 2017        ###
###       Analysis of IMDB Data            ###
###     For What Writers Care About        ###
##############################################

## why this file?
#   * a writer can edit this file without having to find the written content interpsersed amidst code
#   * when editing this file, make sure comments help a writer understand how these pieces fit together

p_movE2017blurb <- paste0("As of early July, 2017, IMDB recorded 12,193 new ",
                          "movies, and the year is not even over yet! ",
                          "This application explores a small subset of the data that IMDB ",
                          "has to offer, looking for interesting things the data can tell us. ",
                          " Data is culled from a subset of over 5000+ records from 2016 and earlier ",
                          "and from July 2017 screen scrapings of online hot lists: 'Top 250 movies', 'Bottom 250 movies', etc.")

sourceDataBlurb <- "The data used in this project can be found under TheMitchWorksPro on "
sourceDataBlurb2 <-"'Data World.'"                   # wrap this in hyperlinks in the code
srcDatBlurb3 <- " Files used in this project are: "  # follow this with variables storing filenames from code

intro_movieRunTimeAnalysis <- paste0(
  "When I studied screenwriting for my undergraduate degree, students were advised to make their ", 
  "feature length movie scripts between 90 and 129 pages. Years Later, this recommendation fell to an end ", 
  "target of just 90 pages. Most recently, a former professor of mine revised the number ",
  "yet again.  The new 'sweet spot' is 110 pages. On average, each page of a screenplay equates to one minute of ",
  "screen time.  Are these numbers just arbitrary or is there something to these guidelines? ")

aboutDataOnVis <- paste0(
  "The 'Kaggle 5000' data was created by extracting movie IDs from over 5000 records posted on Kaggle ",
  "and using these IDs to get a fresh download from IMDB using the OMDB open API.  This data was then merged ",
  "w/ the 'Top' and 'Bottom' lists scraped using XML and jasonlite libraries in R.  The Kaggle IDs were all ",
  "from 2016 and earlier.  The 'Top 250' and 'Bottom 100' lists were all scraped in July of 2017."
)
