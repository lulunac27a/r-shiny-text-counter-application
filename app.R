library(shiny)
library(stringr)

ui <- fluidPage(
    titlePanel("Text Counter Application in R Shiny"),
    sidebarLayout(
        sidebarPanel(
            textAreaInput("text", "Enter text:", rows = 10, cols = 80)
        ),
        mainPanel(
            textOutput("textOutput")
        )
    )
)

server <- function(input, output) {
    output$textOutput <- renderText({
        text <- input$text
        chars <- nchar(text)
        words <- str_count(text, "\\S+")
        lines <- str_count(text, "\n") + 1
        paste("Characters:", chars,
              "\nWords:", words,
              "\nLines:", lines)
    })
}

shinyApp(ui = ui, server = server)