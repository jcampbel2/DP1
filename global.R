library("caret")
library("stringr")
library("ggplot2")
library("plyr")
library("rattle")
library("rpart.plot")
library("randomForest")
library("scales")
library("googleVis")
library("e1071")
suppressPackageStartupMessages(library(googleVis))


##library("knitr")

signif_rup <- function(x, nd=1, high=TRUE){
  base <- signif(x,nd)
  adj <- abs(signif(x,nd)- signif(x,nd+1))
  ##print(paste(base,adj))
  
  an <- 0
  if (adj==0) {
    an <- 0
  } else
      if (adj > 1) {
        adj2 <- adj
        n<-0
        while (adj2 > 1) {
          adj2<-adj2/10
          n<-n+1
        }
        an<-1
        for (t in 1:(n)) an<-an*10
        ##    print(paste("multiple",n,an))
        
      } else if (adj < 1) {
        adj2 <- adj
        n<-0
        while (adj2 < 1) {
          adj2<-adj2*10
          n<-n+1
        }
        an<-1
        for (t in 1:(n-1)) an<-an/10
        ##    print(paste("divide",n,an))
        
      } 
  
  
  if (high==FALSE){
    an <- an*-1
  }
  y <- base + an
  return(y)
}


## load base model
load(file = "SaveModel2.RData")
##rebuild validation details for reprint
val_out3 <- predict(modTreeLtd, validation)
c<-confusionMatrix(val_out3,validation$classe)

##break into separate lists




##create subset df for each outcome from validate
keepcol <-keepvar2
keepcol[53] <- TRUE
dfA <- validation[validation$classe=="A",keepcol]
dfB <- validation[validation$classe=="B",keepcol]
dfC <- validation[validation$classe=="C",keepcol]
dfD <- validation[validation$classe=="D",keepcol]
dfE <- validation[validation$classe=="E",keepcol]

lstClasse <- list(             "A - Exercise carried out correctly"="A", 
                                  "B - Throwing the elbows to the front"="B", 
                                  "C - Lifting the dumbbell only halfway"="C" ,
                                  "D - Lowering the dumbbell only halfway"="D" ,
                                  "E - Throwing the hips to the front"="E" 
)


##calculate ranges for each selector
r_roll_belt <- range(training$roll_belt)
r_pitch_belt <-range(training$pitch_belt)
r_yaw_belt <-range(training$yaw_belt)
r_magnet_dumbbell_x <-range(training$magnet_dumbbell_x)
r_magnet_dumbbell_y <-range(training$magnet_dumbbell_y)
r_magnet_dumbbell_z <-range(training$magnet_dumbbell_z)
r_roll_forearm <-range(training$roll_forearm)
r_pitch_forearm <-range(training$pitch_forearm)

##set significant places to use for selectors
signpl <- 2

t <- data.frame(
        roll_belt=mean(validation$roll_belt), 
        pitch_belt=mean(validation$pitch_belt),
        yaw_belt=0,
        magnet_dumbbell_x=0,
        magnet_dumbbell_y=0,
        magnet_dumbbell_z =0,
        roll_forearm= 0,
        pitch_forearm= 0)
p <-  predict(modTreeLtd, t)





