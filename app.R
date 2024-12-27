# import Shiny library
library(shiny)
# import string library for string manipulation
library(stringr)

# define UI component
ui <- fluidPage(titlePanel("Text Counter Application in R Shiny"),
    sidebarLayout(sidebarPanel(textAreaInput("text", "Enter text:",
        rows = 10, cols = 80)  #text area input
, fileInput("file",
        "Upload a .txt file", accept = ".txt")  #file input accepts .txt text files
),
        mainPanel(textOutput("textOutput")  #text output content
)))

# define server component
server <- function(input, output) {
    output$textOutput <- renderText({
        text <- input$text  #text area box input

        if (!is.null(input$file)) {
            # if file uploaded is not null
            text <- readLines(input$file$datapath)  #read lines of text from uploaded file
            text <- paste(text, collapse = "\n")  #insert text into text area box
        }

        chars <- nchar(text)  #number of characters
        words <- str_count(text, "\\S+")  #number of words
        lines <- str_count(text, "\n") + 1  #number of lines
        paste("Characters:", chars, "\nWords:", words, "\nLines:",
            lines)
    })
}

# run the Shiny web app server
shinyApp(ui = ui, server = server)
