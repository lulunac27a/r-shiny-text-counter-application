# import Shiny library
library(shiny)
# import string library for string manipulation
library(stringr)

# define UI component
ui <- fluidPage(
    titlePanel("Text Counter Application in R Shiny"),
    sidebarLayout(
        sidebarPanel(
            textAreaInput("text", "Enter text:", rows = 10, cols = 80), # text area input
            fileInput("file", "Upload a .txt file", accept = ".txt") # file input accepts .txt text files
        ),
        mainPanel(
            textOutput("textOutput") # text output content
        )
    )
)

# define server component
server <- function(input, output) {
    output$textOutput <- renderText({
        # text area box input
        text <- input$text

        # if file uploaded is not null
        if (!is.null(input$file)) {
            # read lines of text from uploaded file
            text <- readLines(input$file$datapath)
            # insert text into text area box
            text <- paste(text, collapse = "\n")
        }

        # number of characters
        chars <- nchar(text)
        # number of words
        words <- str_count(text, "\\S+")
        # number of lines
        lines <- str_count(text, "\n") + 1
        paste(
            "Characters:",
            format(round(chars, 0), big.mark = ",", scientific = FALSE),
            "\nWords:",
            format(round(words, 0), big.mark = ",", scientific = FALSE),
            "\nLines:",
            format(round(lines, 0), big.mark = ",", scientific = FALSE)
        )
    })
}

# run the Shiny web app server
shinyApp(ui = ui, server = server)
