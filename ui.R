## ui.R ## 
##############################################
###      Data Science Bootcamp 10          ###
###  Project 1 - Exploratory Visualization ###
###     Mitch Abramson  / July 2017        ###
###       Analysis of IMDB Data            ###
###     For What Writers Care About        ###
##############################################

# library(DT)
# library(shiny)
library(shinydashboard)

# uncomment for "Dashboard" Page

source("textContent.R")

# colorSelections <-  <moved into code> # can add selected = value for starting selection
# Not working: displayColSlxns <- TRUE

sidebar <- dashboardSidebar(
  sidebarMenu(
    sidebarUserPanel("TheMitchWorksPro", subtitle ="(TMWP)", image = appImages[3]),  # image 3: movie slate icon
    # note: "dashboard is required first tab:  edit but do not change tabName or delete:
    menuItem("Home", tabName = "dashboard", icon = icon("imdb")),  # original icon: "dashboard"
    menuItem("Data", tabName = "data", icon = icon("database")),
      # menuSubItem("Sub-item 1", tabName = "subitem1"),
      # menuSubItem("Sub-item 2", tabName = "subitem2"),
    
    menuItem("Visualizations", icon = icon("bar-chart"), tabName = "widgets"),
            # not used: badgeLabel = "new", badgeColor = "green"
        
    menuItem("About the Author:", tabName = "no_code", icon=icon("info")),  
    menuItemOutput("lk_in"), br(), br(), br(),
    
    hr(class="sidePhr"), 
    selectInput(inputId = "colorSlxn", 
                   label = "Choose A Visualization Color",     ## colors drop-down
                   choices = colorChoices,
                   selected = "darkgreen",
                   selectize = FALSE, size = 12),   # note: selectize (true drop-down), size does not work
    hr(class="sidePhr")
  )
)

body <- dashboardBody(
 fluidRow(
   tags$head(
     tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
   ),
  
   tabItems(
    
     tabItem(tabName = "dashboard",
            fluidRow(
              tags$h1("IMDB Movie Data Analysis"), hr(class="mainBxhr"),
              img(src="movies_splashimage_lite.jpg", width="100%"),   
                       # image 4: movies header splash image (URL replaced w/ git url during debugging)
              hr(class="mainBxhr"),
              div(p(class="bodyText", p_movE2017blurb),br())
            ),
            fluidRow(
              box(width="100%", title = "Number of Movie Releases By Year", background = "blue", solidHeader = TRUE,
                # future testing: color = "blue"
                plotOutput("mvFrqYrHst2"), hr(class="mainBxhr"),
                sliderInput("histBin", "Select Bin Grouping For Years:",
                          min = 1, max = 30, value = 5), br(), br(), br()),  # box ends here
              tags$small(sourceDataBlurb, a(href=appHyperLnks[1], target="_blank", sourceDataBlurb2),
                                            srcDatBlurb3,
                                            appSrcDatFiles[1], " and ", appSrcDatFiles[2])  
                         # blurbs: about IMDB Data footnote, hyperlink 1: source data on Data World
                         #         future note:  write code to update the file list from appSrcDatFiles later
              ) # fluidRow ends here
     ), 

     tabItem(tabName = "data", 
            # simple histogram bar chart: x = record, then hook color drop-down to it
            fluidRow(h1("IMDB Movie Data"), hr(class="mainBxhr"),
              box(width=4, tableOutput("datRecSum"),
              # invisible table to stop "fluid motion" on this element
              tags$table(tags$tr(tags$td(width="600px",hr()),tags$td(width="*")))
              ),
              box(width=8,   
              plotOutput("mvFrqRecHst")
            )), # fluidRow and second box ends here
            fluidRow(box(width="100%",
              DT::dataTableOutput("table")
            )) # fluidRow / box ends here 
     ),
     
     tabItem(tabName = "widgets",
             fluidRow(
             h1("Movies: Analysis of Runtime"), hr(class="mainBxhr"),
             
             selectizeInput(inputId = "dataSlxn", 
                            label = "Choose A Dataset",     ## data drop-down
                            choices = dataChoices,
                            selected = "250 Top Movies"),
             
             hr(class="mainBxhr")
             ),
             fluidRow(
               # wellPanel(id = "tPanel", style = "overflow-x:scroll; max-width: 920px",
               # supposed to add scroll bars ... did not work
              
                 tags$table(tags$tr(
                   tags$td(width="20px", valign="Top",
                      h2("Data Summary:"),
                      verbatimTextOutput("datRecSum2"), br(),
                      verbatimTextOutput("datRecSum2b"), br() # ,     # ,
                      # verbatimTextOutput("datRecSum2c"), br(),  # formatting issue
                      # verbatimTextOutput("datRecSum2d"), br()   # return to this later (keep 2 col sets for now)
                      
                      # idea:  develop this when there is content to hide ...
                      # actionButton(inputId="moreInfo1", label="Would You Like To Know More? ...", icon=map)
                      ),
                   tags$td(width="700", valign="Top", h2("Movie Duration (Runtime) Over Time"),
                           plotOutput("ggpltRT1"),       # YR Released / Avg Runtime line plot
                           div(p(class="bodyText", br(), intro_movieRunTimeAnalysis),br()))
                 )  
             ) 
     ) # ) ## fluidRow wellpanel (commented out)
   ) ## tabpanel
)))  ## dashboardBody(), fRow(css header + tabitems), tabitems()

# Dashboard Page Components Assembled Here
dashboardPage(skin="purple",
  dashboardHeader(title = "Movie Data App"),
  sidebar,
  body
)

# p("Coming Soon ...")  # use as placeholder when building out new tabs
# not needed yet: # submitButton("Update View"),
# geom_smooth()` using method = 'loess' for main visualization
# library(rsconnect)
