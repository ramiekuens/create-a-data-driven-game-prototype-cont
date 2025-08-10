# w3ro_create_a_data-d.R

# Load necessary libraries
library(shiny)
library(ggplot2)

# Define UI
ui <- fluidPage(
  # Game title
  h1("Data-Driven Game Prototype"),
  
  # Input for player's name
  textInput("player_name", "Enter your name:"),
  
  # Select input for game difficulty
  selectInput("difficulty", "Choose game difficulty:",
              c("Easy", "Medium", "Hard")),
  
  # Button to start the game
  actionButton("start_game", "Start Game"),
  
  # Output for game data
  tableOutput("game_data"),
  
  # Output for game visualization
  plotOutput("game_visualization")
)

# Define server logic
server <- function(input, output) {
  # React to start game button
  game_data <- eventReactive(input$start_game, {
    # Sample game data based on difficulty level
    if (input$difficulty == "Easy") {
      data.frame(score = runif(10, 0, 100), time = runif(10, 0, 60))
    } else if (input$difficulty == "Medium") {
      data.frame(score = runif(10, 50, 150), time = runif(10, 30, 90))
    } else {
      data.frame(score = runif(10, 100, 200), time = runif(10, 60, 120))
    }
  })
  
  # Output game data
  output$game_data <- renderTable({
    game_data()
  })
  
  # Output game visualization
  output$game_visualization <- renderPlot({
    ggplot(game_data(), aes(x = time, y = score)) + 
      geom_point() + 
      labs(x = "Time (s)", y = "Score")
  })
}

# Run the application
shinyApp(ui = ui, server = server)