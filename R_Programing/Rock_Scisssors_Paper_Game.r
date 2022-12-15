print("Wellcome to Rock Paper Scissors game")

## Crate variable to store the score
win <- 0
draw <- 0
lose <- 0


replay <- "Y"
while (replay != "Q") {
  print("please select you hand")
  ## Create Hand dataframe
  handID <- c(1:3)
  handname <- c("Rock","Scissors","Paper")
  handdf <- data.frame(
          handID,
          handname
        )
  print(handdf)
  
  ### Playing stage
  ## player select the hand
  player_hand <- as.numeric(readLines("stdin",n=1))
  com_hand <- as.numeric(sample(handID,1))
  print(com_hand)
  
  ## Use if statement to conclude result
  if (player_hand == com_hand){
    print(paste("Draw ! You choose",
               handdf$handname[player_hand],
               "And Opponent choose",
               handdf$handname[com_hand]))
    draw <- draw+1
  }else if (player_hand == 1 & com_hand == 3) {
    print(paste("Lose ! You choose",
               handdf$handname[player_hand],
               "And Opponent choose",
               handdf$handname[com_hand]))
    lose <- lose+1
  }else if (player_hand > com_hand) {
    print(paste("Lose ! You choose",
               handdf$handname[player_hand],
               "And Opponent choose",
               handdf$handname[com_hand]))
    lose <- lose+1
  }else if (player_hand < com_hand) {
    print(paste("Win ! You choose",
               handdf$handname[player_hand],
               "And Opponent choose",
               handdf$handname[com_hand]))
    win <- win+1
  }
  print("Do you wanna play again ? (Q to quit)")
  replay <- readLines("stdin",n=1)
}
print("Summary score")
print(paste("Win :",win))
print(paste("Draw :",draw))
print(paste("Lose :",lose))