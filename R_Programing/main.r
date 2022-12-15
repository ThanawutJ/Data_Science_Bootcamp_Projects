# ## Home work01
# ## chat bot 

#Login
print("Welcome to Aut's Pizza shop.")
print("Please log in to our system")
print("Write down you user name, and you password in next row.")
un <- readLines("stdin",n=1)
pw <- readLines("stdin",n=1)
print(paste("Hi",un))

## Choose food type 
attemp <- 1
while (attemp < 3) {
  print("What do you need for today")
  foodname <- c("Pizza","Other")
  foodID <- c(1,2)
  fooddf <- data.frame(
    foodID,
    foodname
  )
  colnames(fooddf) <- c("ID","food type")
  print(fooddf)
  action1 <- as.numeric(readLines("stdin",n=1))
  if (action1 == 1) {
    print("Pizza is great for your day")

    ## Asking some question
        print("At First, let me asking your some question")
        print("Why the Pizza is Round")
        ans1 <- readLines("stdin",n=1)
        if(is.null(ans1) == TRUE) {
          print("Dude try more")  
        }else {
          print("sound good, And additional The pizza is round   because of the way it is prepared! Every pizza lover knows that pizza is made from dough, and all dough needs to rise before you get to bake it.")
        }
        print("Are you a Pizza lover ?(Y / N)")
        ans2 <- readLines("stdin",n=1)
        if (ans2 == "N" & is.null(ans2) == FALSE) {
          print("The door is not locked,You can walk out every time you want")
        }else{
          print("You are the right place!")
          
          ##Select size       
          sizeid <- c(1:3)
          PizzaSize <- c("Small","Medium","Large")
          sizedf <- data.frame(
            sizeid,
            PizzaSize
          )
          print(sizedf)
          
          ## while loop reconfirm the size
          sizeChoose <- 0
          while (sizeChoose<10) {
            sizeChoose <- sizeChoose+1
            size <- as.numeric(readLines("stdin",n=1))
            print(paste("Okay you choose the",(PizzaSize[size]),"size."))
            if(size == 1) {
              print("Is that enough?")
              sizeAnswer <- readLines("stdin",n=1)
              if(sizeAnswer == "Y"){
                break
              }else{
                print("1. Small")
                print("2. Medium")
                print("3. Large")
              }
            }else {
              break
            }}
          
          
          
          ##Choose crust
          print("Please select the crust?")
          crustchart <- c("Thin crust","Cheese crust")
          crustchartID <- c(1:2)
          dfCrust <- data.frame(
                        crustchartID,
                        crustchart
                      )
          print(dfCrust)
          print("!Dont make your face like that we have only 2 crusts dude!")
          
          crust <- as.numeric(readLines("stdin",n=1))
          print(paste("You choose",crustchart[crust]))
          
          ## Add ingredient, Toping
          print("What ingredient on top")
          tpID <- c(1:5)
          tpname <- c("Margherita","Supreme","Cheese","Spinach Artichoke","Mashroom")
          toppings <- data.frame(
            tpID,
            tpname
          )
          colnames(toppings) <- c("item_no.","Toping")
          print(toppings)
          toping <- as.numeric(readLines("stdin",n=1))
          
          ## Ask for some beverage 
          print("So hot for today, Any beverage you need ?")
          beverageID <- c(1:5)
          beveragename <- c("Beer","Coke","Pepsi","Green tea","Fresh water")
          bevaragedf <- data.frame(
            beverageID,
            beveragename
          )
          colnames(bevaragedf) <- c("item_no.","Beverage_name")
          print(bevaragedf)
          beverage <- as.numeric(readLines("stdin",n=1))
          
          # Peyment method
          print("Do you prefer to pay on cash or credit card ?")
          
          paymentID <- c(1:2)
          paymentname <- c("Cash","Credit cards")
          paymentdf <- data.frame(
            paymentID,
            paymentname)
          colnames(paymentdf) <- c("Item_no.","Payment_method")
          print(paymentdf)
          payment <- as.numeric(readLines("stdin",n=1))
          
          ## Summary order
          print("All right, you have done here.")
          print(paste("You have order the",
                      sizedf$"PizzaSize"[size],
                      fooddf$"food type"[action1],
                      "with the",
                      dfCrust$crustchart[crust],
                      "with",
                      toppings$"Toping"[toping],
                      "toping and grap some",
                      bevaragedf$"Beverage_name"[beverage],
                      "to make you fresh. Thay all could made your day. And you prefer to pay with",
                      paymentdf$"Payment_method"[payment]
                      )
               )
        
        }
    break
  } else {
    
    attemp <- attemp + 1
    if(attemp == 3) {
      print("You could reach to the exit and find the other one, lol")
    }else{
      print("Arr! the other have sold out,Pizza would be greatest for today")
    }
  }
}






