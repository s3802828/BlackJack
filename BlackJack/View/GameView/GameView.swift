/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Le Quynh Giang
  ID: s3802828
  Created  date: 12/08/2022
  Last modified: 28/08/2022
  Acknowledgement:
    birdmichael. "How to lock screen orientation for a specific view?" developer.apple.com. https://developer.apple.com/forums/thread/128830 (accessed Aug. 18, 2022)
    T.Huynh."RMIT-Casino/RMIT Casino/Views/ContentView.swift".GitHub.https://github.com/TomHuynhSG/RMIT-Casino/blob/main/RMIT%20Casino/Views/ContentView.swift. (accessed Aug. 16, 2022)
    P.Hudson. "How to detect dark mode" Hacking with Swift. https://www.hackingwithswift.com/quick-start/swiftui/how-to-detect-dark-mode (accessed Aug. 18, 2022)
    P.Hudson. "Triggering events repeatedly using a timer". Hacking with Swift. https://www.hackingwithswift.com/books/ios-swiftui/triggering-events-repeatedly-using-a-timer (accessed Aug. 17, 2022)
    iOS Academy, SwiftUI: Circle Fill Animation (2021, Xcode 12, SwiftUI 2.0) - iOS Development (May. 2, 2021). Accessed Aug. 16, 2022. [Online Video]. Available: https://www.youtube.com/watch?v=6tDTMVxn5us
    Inncoder."SwiftUI-Animations/Animations/CreditCardFlip/CreditCardFlip.swift".GitHub.https://github.com/Inncoder/SwiftUI-Animations/blob/master/Animations/CreditCardFlip/CreditCardFlip.swift (accessed Aug. 13, 2022)
 */

import SwiftUI
struct GameView: View {
    @Environment(\.colorScheme) var colorScheme
    //Card deck of everty game
    @State var shuffledCards = cardDeck.shuffled()
    //Scale of 1 card to do zoom out animation
    @State var scaleDealer : [Float] = [0.5,0.5]
    @State var scalePlayer : [Float] = [0.5,0.5]
    //Positions of cards to adjust during animation
    @State var positionXDealer: [Int] = [-30,0]
    @State var positionYDealer:[Int] = [0,0]
    @State var positionXPlayer: [Int] = [-30,0]
    @State var positionYPlayer:[Int] = [0,0]
    //Cards of player/dealer
    @State var playerCards = CardArray()
    @State var dealerCards = CardArray()
    @State var showImageDealer: [Bool] = [true, true]
    @State var showImagePlayer: [Bool] = [true, true]
    //Initiate the duration for count down timer
    @State var countDownTimer = UserDefaults.standard.integer(forKey: "timeLimit")
    let timeLimit = UserDefaults.standard.integer(forKey: "timeLimit")
    let betAmount = UserDefaults.standard.integer(forKey: "betAmount")
    @State var timerRunning = true
    @State var timerY = 120
    //Pushish timer
    let timer = Timer.publish(every: 1, on: .current, in: .common).autoconnect()
    @State var isPlayerTurn = true
    @State private var animating = false
    @State private var isImageFlipped = false
    @State private var rotation: Double = 0
    @State var isEndGame = false
    @State var winner = ""
    //To animate the result badge
    @State var scaleWinner = 0.5
    @State var scaleLoser = 0.5
    @State var fill = 1.0
    @State var isPlayerStand = false
    @State var isDealerStand = false
    //To exit the game
    @Environment(\.dismiss) var dismiss
    @Binding var loggedInUser : [String: Any]
    @State var loggedInUserCopy : [String:Any] = ["currentCoin": 500]
    
    //MARK: END TURN FUNCTION
    func endTurn() {
        isPlayerTurn.toggle()
        timerY *= -1
        fill = 1.0
        timerRunning = false
        countDownTimer = timeLimit
        timerRunning = true
    }
    //MARK: DRAW CARD FUNCTION
    func drawCard(isPlayer: Bool) {
        playSound(sound: "draw_card", type: "mp3")
        if isPlayer {
            if playerCards.cards.count < 5 {
                showImagePlayer.append(true)
                positionXPlayer.append(0)
                positionYPlayer.append(0)
                scalePlayer.append(0.5)
                playerCards.cards.append(shuffledCards[0])
                shuffledCards.remove(at: 0)
                for i in 0..<showImagePlayer.count - 1 {
                    positionXPlayer[i] -= 30
                }
            }
        } else {
            if dealerCards.cards.count < 5 {
                showImageDealer.append(true)
                positionXDealer.append(0)
                positionYDealer.append(0)
                scaleDealer.append(0.5)
                dealerCards.cards.append(shuffledCards[0])
                shuffledCards.remove(at: 0)
                for i in 0..<showImageDealer.count - 1 {
                    positionXDealer[i] -= 30
                }
            }
        }
        self.endTurn()
    }
    //MARK: RESET GAME
    func resetGame() {
        //Reset almost state variables to their initial state
        isEndGame = false
        countDownTimer = timeLimit
        timerRunning = true
        isPlayerTurn = true
        timerY = 120
        fill = 1.0
        isPlayerStand = false
        isDealerStand = false
        winner = ""
        playSound(sound: "new-game", type: "wav")
        playerCards.cards.removeAll()
        dealerCards.cards.removeAll()
        shuffledCards = cardDeck.shuffled()
        playerCards.cards.append(shuffledCards[0])
        shuffledCards.remove(at: 0)
        playerCards.cards.append(shuffledCards[0])
        shuffledCards.remove(at: 0)
        dealerCards.cards.append(shuffledCards[0])
        shuffledCards.remove(at: 0)
        dealerCards.cards.append(shuffledCards[0])
        
        shuffledCards.remove(at: 0)
        
        showImagePlayer.removeAll()
        showImagePlayer.append(contentsOf: [true, true])
        
        showImageDealer.removeAll()
        showImageDealer.append(contentsOf: [true, true])
        
        scaleDealer.removeAll()
        scaleDealer.append(contentsOf: [0.5, 0.5])
        scalePlayer.removeAll()
        scalePlayer.append(contentsOf: [0.5,0.5])
        
        positionXPlayer.removeAll()
        positionXPlayer.append(contentsOf: [-30,0])
        
        positionYPlayer.removeAll()
        positionYPlayer.append(contentsOf: [0,0])
        
        positionXDealer.removeAll()
        positionXDealer.append(contentsOf: [-30,0])
        
        positionYDealer.removeAll()
        positionYDealer.append(contentsOf: [0,0])
        
        isImageFlipped = false
        animating = false
        rotation = 0.0
        
        isDealerStand = false
        isPlayerStand = false
    }
    //MARK: SAVE USER INFO
    func modifyDatabase(){
        let userArray: [Dictionary<String, Any>] = UserDefaults.standard.array(forKey: "userInfo") as? [Dictionary<String, Any>] ?? [];
        var userArrayCopy = userArray
        var idx = 0
        for i in userArrayCopy {
            //Find the current user
            if i["username"] as! String == loggedInUserCopy["username"] as! String {
                var iCopy = i
                iCopy["currentCoin"] = loggedInUserCopy["currentCoin"] as! Int
                iCopy["highestCoin"] = loggedInUserCopy["highestCoin"] as! Int
                userArrayCopy[idx] = iCopy
                break
            }
            idx += 1
        }
        loggedInUser = loggedInUserCopy
        UserDefaults.standard.set(userArrayCopy, forKey: "userInfo")
    }
    //MARK: CHECK WINNING
    func checkWinning()  {
        let playerPoint = playerCards.calculateTotalValue(isEndGame: true)
        let dealerPoint = dealerCards.calculateTotalValue(isEndGame: true)
        //MARK: CASE 1: Both got AA or Blackjack
        if (playerCards.isAA() && dealerCards.isAA())  || (playerCards.isBlackJack() && dealerCards.isBlackJack()){
            timerRunning = false
            withAnimation(Animation.linear(duration: 0.3)) {
                self.animating.toggle()
            }
            winner = "dealer"
            //Adjust the currentCoin of player
            if (playerCards.isAA()){
                loggedInUserCopy["currentCoin"] = loggedInUserCopy["currentCoin"] as! Int - betAmount * 2
            } else {
                loggedInUserCopy["currentCoin"] = loggedInUserCopy["currentCoin"] as! Int - betAmount
            }
            isEndGame = true
            //MARK: CASE 2 : Only 1 got AA
        } else if playerCards.isAA() || dealerCards.isAA() {
            timerRunning = false
            withAnimation(Animation.linear(duration: 0.3)) {
                self.animating.toggle()
            }
            if dealerCards.isAA() {
                loggedInUserCopy["currentCoin"] = loggedInUserCopy["currentCoin"] as! Int - betAmount * 2
                winner = "dealer"
            } else {
                loggedInUserCopy["currentCoin"] = loggedInUserCopy["currentCoin"] as! Int  + betAmount * 2
                winner = "player"
            }
            isEndGame = true
            //MARK: CASE 3 : Only 1 got Blackjack
        } else if playerCards.isBlackJack() || dealerCards.isBlackJack(){
            timerRunning = false
            withAnimation(Animation.linear(duration: 0.3)) {
                self.animating.toggle()
            }
            if dealerCards.isBlackJack() {
                loggedInUserCopy["currentCoin"] = loggedInUserCopy["currentCoin"] as! Int - betAmount
                winner = "dealer"
            } else {
                loggedInUserCopy["currentCoin"] = loggedInUserCopy["currentCoin"] as! Int + betAmount
                winner = "player"
            }
            isEndGame = true
            //Only check these cases when both have stood
        } else if isPlayerStand && isDealerStand {
            //MARK: CASE 4 : Both got magic 5
            if playerCards.isMagicFive() && dealerCards.isMagicFive(){
                timerRunning = false
                withAnimation(Animation.linear(duration: 0.3)) {
                    self.animating.toggle()
                }
                if dealerPoint < playerPoint {
                    loggedInUserCopy["currentCoin"] = loggedInUserCopy["currentCoin"] as! Int - betAmount
                    winner = "dealer"
                } else if dealerPoint == playerPoint {
                    winner = "tie"
                } else {
                    winner = "player"
                    loggedInUserCopy["currentCoin"] = loggedInUserCopy["currentCoin"] as! Int + betAmount
                }
                isEndGame = true
                //MARK: CASE 5 : Only 1 got magic 5
            } else if playerCards.isMagicFive() || dealerCards.isMagicFive(){
                timerRunning = false
                withAnimation(Animation.linear(duration: 0.3)) {
                    self.animating.toggle()
                }
                if dealerCards.isMagicFive() {
                    loggedInUserCopy["currentCoin"] = loggedInUserCopy["currentCoin"] as! Int - betAmount
                    winner = "dealer"
                } else {
                    winner = "player"
                    loggedInUserCopy["currentCoin"] = loggedInUserCopy["currentCoin"] as! Int + betAmount
                }
                isEndGame = true
                //MARK: CASE 6 : Both in Safe Range
            } else if 16 <= playerPoint && playerPoint <= 21 && dealerPoint <= 21 && dealerPoint >= 16 {
                timerRunning = false
                withAnimation(Animation.linear(duration: 0.3)) {
                    self.animating.toggle()
                }
                if dealerPoint > playerPoint {
                    loggedInUserCopy["currentCoin"] = loggedInUserCopy["currentCoin"] as! Int - betAmount
                    winner = "dealer"
                } else if dealerPoint == playerPoint {
                    winner = "tie"
                } else {
                    loggedInUserCopy["currentCoin"] = loggedInUserCopy["currentCoin"] as! Int + betAmount
                    winner = "player"
                }
                isEndGame = true
                //MARK: CASE 7 : Only 1 in Safe Range
            } else if (16 <= playerPoint && playerPoint <= 21) || (dealerPoint <= 21 && dealerPoint >= 16) {
                timerRunning = false
                withAnimation(Animation.linear(duration: 0.3)) {
                    self.animating.toggle()
                }
                if dealerPoint <= 21 && dealerPoint >= 16 {
                    loggedInUserCopy["currentCoin"] = loggedInUserCopy["currentCoin"] as! Int - betAmount
                    winner = "dealer"
                } else {
                    loggedInUserCopy["currentCoin"] = loggedInUserCopy["currentCoin"] as! Int + betAmount
                    winner = "player"
                }
                isEndGame = true
                //MARK: CASE 8 : Only one got busted, the other dirty stand
            } else if (playerPoint > 21 && dealerPoint < 16) || (dealerPoint > 21 && playerPoint < 16) {
                timerRunning = false
                withAnimation(Animation.linear(duration: 0.3)) {
                    self.animating.toggle()
                }
                if dealerPoint > 21 {
                    loggedInUserCopy["currentCoin"] = loggedInUserCopy["currentCoin"] as! Int - betAmount
                    winner = "dealer"
                } else {
                    loggedInUserCopy["currentCoin"] = loggedInUserCopy["currentCoin"] as! Int + betAmount
                    winner = "player"
                }
                isEndGame = true
                //MARK: CASE 9 : Both got busted or both dirty stand
            } else {
                timerRunning = false
                withAnimation(Animation.linear(duration: 0.3)) {
                    self.animating.toggle()
                }
                winner = "tie"
                isEndGame = true
            }
        }
        //reset the coin when user reach 0
        if loggedInUserCopy["currentCoin"] as! Int == 0 {
            loggedInUserCopy["currentCoin"] = 500
        }
        //set new high sore (if any)
        if loggedInUserCopy["currentCoin"] as! Int > loggedInUserCopy["highestCoin"] as! Int {
            loggedInUserCopy["highestCoin"] = loggedInUserCopy["currentCoin"]
        }
        //play result sound
        if winner == "player"{
            playSound(sound: "win", type: "mp3")
        } else if winner == "dealer"{
            playSound(sound: "lose", type: "mp3")
        } else if winner == "tie" {
            playSound(sound: "tie", type: "wav")
        }
        //save user info
        modifyDatabase()
    }
    var body: some View {
        ZStack{
            //set background color based on display mode
            colorScheme == .dark ? Color.white.edgesIgnoringSafeArea(.all) : Color.black.edgesIgnoringSafeArea(.all)
            //MARK: PLAYING TABLE
            Capsule()
                .strokeBorder(colorScheme == .dark ? .gray : .white, lineWidth: 20)
                .background(Capsule().fill(ColorConstants.shinyGold))
                .overlay(Image("dark-logo-no-background").resizable().scaledToFit().scaleEffect(0.3))
                .frame(width: (UIScreen.main.bounds.width - 100),height: (UIScreen.main.bounds.height - 90))
            ZStack{
                //MARK: DRAW CARD BUTTON
                if !isEndGame {
                    Button(action: {
                        if isPlayerTurn && playerCards.calculateTotalValue(isEndGame: false) < 21 {
                            self.drawCard(isPlayer: true)
                            if isDealerStand {
                                self.endTurn()
                            }
                        }
                    }, label: {
                        Image("hidden")
                    })
                } else {
                    //MARK: END GAME BUTTONS
                    VStack {
                        Button(action: {
                            stopPlayer()
                            self.resetGame()
                            self.checkWinning()
                        }, label: {
                            Capsule()
                                .fill(Color.black)
                                .padding(8)
                                .frame(width: 200, height:50)
                                .overlay(Text("New Game")
                                    .font(.system(.title3, design: .rounded))
                                    .fontWeight(.bold)
                                    .foregroundColor(ColorConstants.boldGold))
                        }).offset(x: CGFloat(200))
                        
                        Button(action: {
                            dismiss()
                        }, label: {
                            Capsule()
                                .fill(Color.black)
                                .padding(8)
                                .frame(width: 200, height:50)
                                .overlay(Text("Exit")
                                    .font(.system(.title3, design: .rounded))
                                    .fontWeight(.bold)
                                    .foregroundColor(ColorConstants.boldGold))
                        }).offset(x: CGFloat(200))
                    }
                    
                }
                
                ZStack{
                    ZStack{
                        ZStack {
                            //MARK: DEALER & PLAYER IMAGE
                            VStack{
                                Image("player")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    
                                Text("$\(String(loggedInUserCopy["currentCoin"] as! Int))")
                                    .font(.system(size: 25))
                                    .foregroundColor(ColorConstants.boldGold)
                                    .bold()
                            }.offset(x: CGFloat(-200),y:CGFloat(120))
                            
                            Image("dealer")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .offset(x: CGFloat(-200),y:CGFloat(-120))
                            //MARK: RESULT BADGE
                            if winner != ""{
                                ResultBadge(result: winner == "tie" ? "tie" : "winner")
                                    .scaleEffect(CGFloat(scaleWinner))
                                    .offset(x: CGFloat(-280),y: winner == "player" || winner == "tie" ? CGFloat(120) : CGFloat(-120))
                                    .onAppear(){
                                        let baseAnimation = Animation.easeInOut(duration: 1)
                                        let repeated = baseAnimation.repeatCount(1) //Only play the animation once
                                        withAnimation(repeated){
                                            scaleWinner = 1.0
                                        }
                                    }
                                ResultBadge(result: winner == "tie" ? "tie" : "loser")
                                    .scaleEffect(CGFloat(scaleLoser))
                                    .offset(x: CGFloat(-280),y: winner == "player" || winner == "tie" ? CGFloat(-120) : CGFloat(120))
                                    .onAppear(){
                                        let baseAnimation = Animation.easeInOut(duration: 1)
                                        let repeated = baseAnimation.repeatCount(1) //Only play the animation once
                                        withAnimation(repeated){
                                            scaleLoser = 1.0
                                        }
                                    }
                            }
                            //MARK: TIME CIRCLE
                            if !isEndGame {
                                Circle()
                                    .trim(from: 0.0, to: self.fill)
                                    .stroke(lineWidth: 8).frame(width: 80, height: 80)
                                    .foregroundColor(Color.green)
                                    .rotationEffect(.init(degrees: -90))
                                    .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                                    .offset(x: CGFloat(-200),y:CGFloat(timerY))
                                    .onReceive(timer){ _ in
                                        //MARK: DEALER AI
                                        if  countDownTimer > 0 && timerRunning {
                                            countDownTimer -= 1
                                            //Circle represent for running timer
                                            fill -= 1.0/Double(timeLimit)
                                            //random time dealer give decision
                                            let randomTime = Int.random(in: 2...(timeLimit - 2))
                                            if !isPlayerTurn && countDownTimer <= (timeLimit - randomTime) {
                                                let dealerPoints = dealerCards.calculateTotalValue(isEndGame: false)
                                                //total value is still under 11, dealer has to draw more
                                                if dealerPoints <= 11 && dealerCards.cards.count < 5 {
                                                    self.drawCard(isPlayer: false)
                                                    if isPlayerStand{
                                                        self.endTurn()
                                                    }
                                                    //total value is under 18, random number to decide draw or stand
                                                } else if dealerPoints < 18 && dealerCards.cards.count < 5 {
                                                    let randomNumber = Int.random(in: 0...100)
                                                    if randomNumber < 50 {
                                                        self.drawCard(isPlayer: false)
                                                        if isPlayerStand{
                                                            self.endTurn()
                                                        }
                                                    } else {
                                                        isDealerStand = true
                                                        self.endTurn()
                                                        if isPlayerStand {
                                                            checkWinning()
                                                        }
                                                    }
                                                    //otherwise, dealer has to stand
                                                } else {
                                                    isDealerStand = true
                                                    self.endTurn()
                                                    if isPlayerStand {
                                                        checkWinning()
                                                    }
                                                }
                                            }
                                        } else {
                                            //If run out of timer, the player/dealer would automatically stand
                                            if isPlayerTurn {
                                                isPlayerStand = true
                                                if isDealerStand {
                                                    checkWinning()
                                                }
                                            } else {
                                                isDealerStand = true
                                                if isPlayerStand {
                                                    checkWinning()
                                                }
                                            }
                                            self.endTurn()
                                        }
                                    }
                            }
                        }
                        ZStack {
                            //MARK: PLAYING CARDS
                            PlayCards(isPlayer: true, scaleDealer: $scaleDealer, scalePlayer: $scalePlayer, positionXDealer: $positionXDealer, positionYDealer: $positionYDealer, positionXPlayer: $positionXPlayer, positionYPlayer: $positionYPlayer, playerCards: $playerCards, dealerCards: $dealerCards, showImagePlayer: $showImagePlayer, showImageDealer: $showImageDealer, isImageFlipped: $isEndGame)
                            
                            PlayCards(isPlayer: false, scaleDealer: $scaleDealer, scalePlayer: $scalePlayer, positionXDealer: $positionXDealer, positionYDealer: $positionYDealer, positionXPlayer: $positionXPlayer, positionYPlayer: $positionYPlayer, playerCards: $playerCards, dealerCards: $dealerCards, showImagePlayer: $showImagePlayer, showImageDealer: $showImageDealer, isImageFlipped: $isImageFlipped)
                                .rotation3DEffect(.degrees(rotation), axis: (x: 0, y: 1, z: 0))
                                .onAppear {
                                    //Flip card of dealer when end game
                                    Timer.scheduledTimer(withTimeInterval: 0.008, repeats: true) { _ in
                                        if self.animating {
                                            withAnimation(Animation.linear(duration: 0.008)) {
                                                self.rotation += 3
                                            }
                                            if self.rotation == 90 || self.rotation == 270 {
                                                self.isImageFlipped.toggle()
                                            } else if self.rotation == 360 || self.rotation == 180 {
                                                self.animating = false
                                            }
                                            
                                            if self.rotation == 360 {
                                                self.rotation = 0
                                            }
                                        }
                                    }
                                    
                                }
                        }
                        //MARK: STAND BUTTON
                        if isPlayerTurn && !isEndGame {
                            Button(action: {
                                if playerCards.calculateTotalValue(isEndGame: true) > 11 || playerCards.cards.count == 5 {
                                    playSound(sound: "stand", type: "mp3")
                                    isPlayerStand = true
                                    self.endTurn()
                                    if isDealerStand {
                                        checkWinning()
                                    }
                                }
                            }, label: {
                                Capsule()
                                    .fill(ColorConstants.boldGold)
                                    .padding(8)
                                    .frame(width: 200, height:50)
                                    .overlay(Text("Stand")
                                        .font(.system(.title3, design: .rounded))
                                        .fontWeight(.bold)
                                        .foregroundColor(Color.black))
                            }).offset(y: CGFloat(200))
                        }
                    }
                }
            }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        }.onAppear(){
            stopPlayer()
            //Force orientation of this view to be landscape
            AppDelegate.orientationLock = UIInterfaceOrientationMask.landscape
            UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation")
            UINavigationController.attemptRotationToDeviceOrientation()
            playSound(sound: "new-game", type: "wav")
            loggedInUserCopy = loggedInUser //set up user
            //deal the first round's cards
            playerCards.cards.append(shuffledCards[0])
            shuffledCards.remove(at: 0)
            playerCards.cards.append(shuffledCards[0])
            shuffledCards.remove(at: 0)
            dealerCards.cards.append(shuffledCards[0])
            shuffledCards.remove(at: 0)
            dealerCards.cards.append(shuffledCards[0])
            shuffledCards.remove(at: 0)
            checkWinning() //check 1st round result
        }.onDisappear(perform: {
            playSound(sound: "welcome", type: "mp3")
            //Put orientation back to default
            DispatchQueue.main.async {
                AppDelegate.orientationLock = UIInterfaceOrientationMask.portrait
                UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
                UINavigationController.attemptRotationToDeviceOrientation()
            }
        })
        
    }
}
struct ResultBadge : View {
    var result: String
    var body: some View{
        ZStack{
            Image(result == "tie" ? "tie-badge" : (result == "winner" ? "winner-badge" : "loser-badge"))
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
        }
        
    }
}

