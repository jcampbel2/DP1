

lstModel <- function(){
  
  rval <- list("Prediction Accuracy on Validaiton Data"="A","Model Accuracy Summary Stats"="B",
               "Plot of Accuracy as Number of Trees Increase"="C", "Plot of Relative Importance of Predictors"="D")
  return(rval)
  
}

shinyUI(fluidPage(responsive = TRUE,
  titlePanel(paste("Interactive version of Predictive Model")),
  
#  sidebarLayout(
#    sidebarPanel(
            
       
      
      
#    ),
    
    mainPanel(width = 12  ,
      tabsetPanel(type = "tab",id="tabid",position = "above" 
                  ,tabPanel(title = "Info", value = 1
                           ,helpText("This predictive model is based on an assignment from the Coursera Machine Learning
                Course and uses the Random Forest approach.  The model shown is limited to only use 
               the top 8 predictive variables rather than the 24 originally used")
                            ,br()
                          ,helpText("This app has several tabs which allow you;")
                        ,h6("Predict - Run your own prediction")
                        ,h6("Test Data - Get validation data (including actual outcome")
                        ,h6("Model - Plots and validation info on model")
                        ,h6("Original Project - View the original project")
                        
                  )
                  ,tabPanel(title = "Predict", value = 2, 
                      sidebarLayout(
                        sidebarPanel(width = 4,
                          h5("Set predictor variables using sliders")
                          ,h6("Belt Sensors")
                          ,sliderInput(inputId = "ipitch_belt",label = "Pitch Belt",
                                       min = signif_rup(r_pitch_belt[1],nd = signpl,high = FALSE ), 
                                       max= signif_rup(r_pitch_belt[2],nd = signpl,high = TRUE ),
                                       value = mean(r_pitch_belt))
                          ,sliderInput(inputId = "iroll_belt",label = "Roll Belt",
                                       min = signif_rup(r_roll_belt[1],nd = signpl,high = FALSE ), 
                                       max= signif_rup(r_roll_belt[2],nd = signpl,high = TRUE ),
                                       value = mean(r_roll_belt))
                          ,sliderInput(inputId = "iyaw_belt",label = "Yaw Belt",
                                       min = signif_rup(r_yaw_belt[1],nd = signpl,high = FALSE ), 
                                       max= signif_rup(r_yaw_belt[2],nd = signpl,high = TRUE ),
                                       value = mean(r_yaw_belt))
                          ,br()
                          ,h6("Dumb Bell Sensors")
                          ,sliderInput(inputId = "imagnet_dumbbell_x",label = "Magnet Dumbbell X axis",
                                       min = signif_rup(r_magnet_dumbbell_x[1],nd = signpl,high = FALSE ), 
                                       max= signif_rup(r_magnet_dumbbell_x[2],nd = signpl,high = TRUE ),
                                       value = mean(r_magnet_dumbbell_x))
                          ,sliderInput(inputId = "imagnet_dumbbell_y",label = "Magnet Dumbbell Y axis",
                                       min = signif_rup(r_magnet_dumbbell_y[1],nd = signpl,high = FALSE ), 
                                       max= signif_rup(r_magnet_dumbbell_y[2],nd = signpl,high = TRUE ),
                                       value = mean(r_magnet_dumbbell_y))
                          ,sliderInput(inputId = "imagnet_dumbbell_z",label = "Magnet Dumbbell Z axis",
                                       min = signif_rup(r_magnet_dumbbell_z[1],nd = signpl,high = FALSE ), 
                                       max= signif_rup(r_magnet_dumbbell_z[2],nd = signpl,high = TRUE ),
                                       value = mean(r_magnet_dumbbell_z))
                          ,br()
                          ,h6("Forearm Sensors")
                          ,sliderInput(inputId = "iroll_forearm",label = "Forearm Roll",
                                       min = signif_rup(r_roll_forearm[1],nd = signpl,high = FALSE ), 
                                       max= signif_rup(r_roll_forearm[2],nd = signpl,high = TRUE ),
                                       value = mean(r_roll_forearm))
                          ,sliderInput(inputId = "ipitch_forearm",label = "Forearm Pitch",
                                       min = signif_rup(r_pitch_forearm[1],nd = signpl,high = FALSE ), 
                                       max= signif_rup(r_pitch_forearm[2],nd = signpl,high = TRUE ),
                                       value = mean(r_pitch_forearm))
                          ,submitButton(text = "Predict Outcome")
                        ##end of side panel  
                        ),
                        mainPanel(width = 8,
                          h5("Model Prediction")
                          ,helpText("Set the sliders on the left panel to whatever values you want and then 
                                    use the predict button at the bottom to run a model prediction.
                                      If you want to check the model accuracy you can get validated data on the ",em("Test Data"), 
                                    " tab which will also give you the actual outcome.")
                          ,br()
                          ,h6("Predicted outcome")
                          ,textOutput(outputId = "predictiontxt")
                          )
                      )
                           
                  )
                  ,tabPanel(title = "Test Data", value = 3, 
                           titlePanel("Get validated test data"),
                           sidebarLayout(
                             sidebarPanel(width = 3
                                      ,radioButtons("rClasse",label = "Select Outcome (Classe)",choices = lstClasse)    
                                      ,numericInput("tstnum", label = "Select number of test values",value = 1,min = 1,max = 20,step = 1)
                                      ,submitButton(text = "Get Data")
                             ),
                             mainPanel(width = 9,
                                       h5("Validated predictors for ",textOutput("selClasse") )
                                       ,br()
                                       ,htmlOutput("testData")
                             )
                           )
                             
                                          
                  )
                  ,tabPanel(title = "Model", value = 4 
                                              ,verbatimTextOutput("c")
                                              ,plotOutput("plot1")
                                              ,plotOutput("plot2")
                           )
                           
                  
                  ,tabPanel(title = "Original Project", value = 5
                           , includeHTML(path = "ML_Assign.html")
                  )
                  
      ) ##tabpanel
      
    ) ##mainPanel

)## fluidpage
)##shinyui

