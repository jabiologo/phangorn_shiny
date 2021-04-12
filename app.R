library(shiny)
library(phangorn)
library(ape)
library(phytools)


# Define UI for data upload app ----
ui <- fluidPage(
  
  titlePanel("phylotree"),
  
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      # Input: Select a file ----
      fileInput("file1", "alignment",
                multiple = TRUE,
                accept = "dna"),
      
      h5("Introduce alignment in interleaved format", align = 'justify',     
         tags$style(HTML("
      @import url('//fonts.googleapis.com/css?family=Lobster|Cabin:400,700');
      
      h5 {
        line-height: 2;
        color: #4D4D4D;
      }

    "))),
      width = 3
      # nugget
      
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      fluidRow(
        
        column(8, plotOutput("tree")
        )
      # Output: Data file ----
      
      
    )
    
  )
)

)

# Define server logic to read selected file ----
server <- function(input, output) {
  
  output$tree <- renderPlot({
    
    req(input$file1)
    primates <- read.phyDat(input$file1$datapath, format = "interleaved", type = "DNA")
    dm  <- dist.ml(primates)
    treeUPGMA  <- upgma(dm)
    plot(treeUPGMA, main="UPGMA")
    
  })
  
}

# Create Shiny app ----
shinyApp(ui, server)