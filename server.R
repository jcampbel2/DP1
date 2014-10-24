


shinyServer(
  function(input, output, session) {

   

  
    output$predictiontxt <- renderText({
      
      t <- data.frame(
        roll_belt=input$iroll_belt, 
        pitch_belt=input$ipitch_belt,
        yaw_belt=input$iyaw_belt,
        magnet_dumbbell_x=input$imagnet_dumbbell_x,
        magnet_dumbbell_y=input$imagnet_dumbbell_y,
        magnet_dumbbell_z =input$imagnet_dumbbell_z,
        roll_forearm= input$iroll_forearm,
        pitch_forearm= input$ipitch_forearm)
      
      p <-  as.character(predict(modTreeLtd, t))
      
      retval <- switch(p, 
                       A="A - Exercise carried out correctly", 
                       B="B - Throwing the elbows to the front", 
                       C="C - Lifting the dumbbell only halfway" ,
                       D="D - Lowering the dumbbell only halfway" ,
                       E="E - Throwing the hips to the front" ,
                       "Error in prediction model")
      return(retval)
    })
    
    output$testData <-renderGvis({
          gvisTable(data = gettestdata() ,
                    options=list(
                    page="enable", pageSize=10,
                    sortColumn=1,  
                    width="100%",height="350"))
          })
    
    gettestdata <- reactive({
          sw <- input$rClasse
          num <- input$tstnum
          if (sw=="A") {
              r <- sample(1:length(dfA[,1]),num)
              df <- dfA[r,]
          } else if (sw=="B") {
              r <- sample(1:length(dfB[,1]),num)
              df <- dfB[r,]
          } else if (sw=="C") {
              r <- sample(1:length(dfC[,1]),num)
              df <- dfC[r,]
          } else if (sw=="D") {
              r <- sample(1:length(dfD[,1]),num)
              df <- dfD[r,]
          } else if (sw=="E") {
              r <- sample(1:length(dfE[,1]),num)
              df <- dfE[r,]
          } else  {
              df <- data.frame(r="Error")
          }
          return(df[,-9])
          })
    
  output$plot1 <- renderPlot(height = 400,{
      plot(modTreeLtd, main="Model Error by outcome v's Number of tree in forest")
      legend("topright", colnames(modTreeLtd$err.rate),col=1:6,cex=0.8,fill=1:6)
    })
    
    output$plot2 <- renderPlot({
        varImpPlot(modTreeLtd, main="Figure 1 - Predictors in Order of Importance")

    })

    output$c <- renderPrint ({
      print(c)  
    })
  }
)  ##shinyServer