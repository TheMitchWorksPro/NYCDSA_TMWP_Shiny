## server.R ##
##############################################
###      Data Science Bootcamp 10          ###
###  Project 1 - Exploratory Visualization ###
###     Mitch Abramson  / July 2017        ###
###       Analysis of IMDB Data            ###
###     For What Writers Care About        ###
##############################################

# library(DT)
# library(shiny)
library(ggplot2)
library(grid)  # for x and y axis tickmarks

# library(googleVis)
# suppressPackageStartupMessages(library(googleVis))

shinyServer(function(input, output){

  # main panel items (visible when dashboard icon is selected)
  output$mvFrqYrHst2 <- renderPlot({ 
    # bins_data <- seq(dataMinYr, generate_YrSeqEnd(input$histBin), input$histBin)  
    
    movieFreqByYrHist2 <- ggplot(IMDB_Main_tl_flds, aes_string(x = "YR_Released")) +
      geom_histogram(colour = "navy", fill = input$colorSlxn, binwidth = input$histBin) +
      labs(title=paste0("Histogram: ", input$histBin," Year Bins")) +
      labs(x="Year", y="Releases") + theme_bw() +
      # scale_y_continuous(breaks=seq(0, 350, 10)) +
      scale_x_continuous(breaks=seq(1910, 2020, 10))
    
    movieFreqByYrHist2
  })

  ## Summary bar chart at top of Data Tab
  output$mvFrqRecHst <- renderPlot({ 
    
    movieFreqByRecHist <- ggplot(recSummary, aes(x = Record, y = recCount)) +
      geom_bar(colour = "navy", fill = input$colorSlxn, stat="identity") +   # input$colorSlxn "darkgreen"
      coord_flip() +
      labs(title=paste0("In This Data Set:")) +
      labs(x="Record Source (Which IMDB Sourced Record Set)", y="Number of Records") + theme_bw() # +
      # scale_x_continuous(breaks=c(0, 1000, 2000, 3000, 4000, 5000))

    movieFreqByRecHist
  })
    
  output$table <- DT::renderDataTable({
    datatable(IMDB_AllData, rownames=FALSE, filter = 'top', 
              options = list(pageLength = dt_plngth, autoWidth = TRUE)) %>% 
      formatStyle(input$selected,
                  background="skyblue", fontWeight='bold')
                  # future research: https://rstudio.github.io/DT/
  })
  
  output$datRecSum <- renderTable ({
    recSummary
  })
  
  # Visualizations tab - Numeric Summary data   "250 Top Movies"
  summary_data_set1 <- reactive ({
    # prototype to filter data for renderPrint summaries
    IMDB_AllNUmericDatSum <- IMDB_AllData %>% filter(., Record==input$dataSlxn) %>%
       select(YR_Released, Runtime, Rating, Num_Reviews) %>% summary()
    return(IMDB_AllNUmericDatSum)
  })
  
  output$rowCount <- renderPrint({
    ncount <- IMDB_AllData %>% filter(., Record==input$dataSlxn) %>% nrow()
    paste0(ncount, ' observations.')
  })
  
  output$datRecSum2 <- renderPrint ({
    # IMDB_AllNUmericDatSum[, c(1,4)]  
    summary_data_set1()[ , c(1,2)]      # 1,2
  })

  output$datRecSum2b <- renderPrint ({
    summary_data_set1()[ , c(4,3)]     # 4,3
  })
  
  output$datRecSum2c <- renderPrint ({
    summary_data_set1()[, 4]  # attempt to do just one col at a time not working
                              # return here later ...
  })
  
  output$datRecSum2d <- renderPrint ({
    summary_data_set1()[, 3]  # part of one col at a time idea ... return here later
  })  

  # Visualization Tab - ggplot of Runtime
  
  ggplot_rt_data_set1 <- reactive ({

    mv_byEachYr <- IMDB_AllData %>% filter(., Record==input$dataSlxn) %>% 
      group_by(., YR_Released) %>%  summarise(., avgRunTime = round(mean(Runtime)), na.rm = TRUE)
      return(mv_byEachYr)
    
    # warning on console: `geom_smooth()` using method = 'loess'
    
  })  
  
  output$ggpltRT1 <- renderPlot ({
    # idea:
    # can we store previous selection in a global and use it to keep a different default color?
  
    g_rby <- ggplot(data = ggplot_rt_data_set1(), aes(y = avgRunTime, x = YR_Released)) + 
      geom_smooth(colour=input$colorSlxn) + 
      geom_point(na.rm=TRUE) + xlab("Year Released") + ylab("Duration (Runtime in Minutes)") + 
      scale_y_continuous(breaks=seq(0, 350, 10)) +
      scale_x_continuous(breaks=seq(1910, 2020, 10))
    
    g_rby  # rby = runtime by year
  })

  # dashboard items that are just links to other sites
  output$lk_in = renderMenu ({
    menuItem("LinkedIn", icon = icon("linkedin-square"),
             href = "https://www.linkedin.com/in/mitchleeabramson/")
  })
  
})