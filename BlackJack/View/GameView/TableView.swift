//
//  TableView.swift
//  BlackJack
//
//  Created by Giang Le on 12/08/2022.
//

import SwiftUI
struct TableView: View {
    @State var shuffledCards = cardDeck
    @State var scaleDealer : [Float] = [0.5,0.5]
    @State var scalePlayer : [Float] = [0.5,0.5]
    @State var positionXDealer: [Int] = [-30,0]
    @State var positionYDealer:[Int] = [0,0]
    @State var positionXPlayer: [Int] = [-30,0]
    @State var positionYPlayer:[Int] = [0,0]
    @State var playerCards = CardArray()
    @State var dealerCards = CardArray()
    @State var showImageDealer: [Bool] = [true, true]
    @State var showImagePlayer: [Bool] = [true, true]
    @State var countDownTimer = 30
    @State var timerRunning = true
    @State var timerY = 120
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var isPlayerTurn = true
    @State private var animating = false
    @State private var isImageFlipped = false
    @State private var rotation: Double = 0
    @State var isEndGame = false
    @State var winner = ""
    @State var scaleWinner = 0.5
    @State var scaleLoser = 0.5
    @State var fill = 1.0
    @State var isPlayerStand = false
    @State var isDealerStand = false
    @Environment(\.dismiss) var dismiss
    @State var isLinkActive = false
    func endTurn() {
        isPlayerTurn.toggle()
        timerY *= -1
        fill = 1.0
        timerRunning = false
        countDownTimer = 30
        timerRunning = true
    }
    func drawCard(isPlayer: Bool) {
        if isPlayer {
            showImagePlayer.append(true)
            positionXPlayer.append(0)
            positionYPlayer.append(0)
            scalePlayer.append(0.5)
            playerCards.cards.append(shuffledCards[0])
            shuffledCards.remove(at: 0)
            for i in 0..<showImagePlayer.count - 1 {
                positionXPlayer[i] -= 30
            }
        } else {
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
        self.endTurn()
    }
    
    func resetGame() {
        isEndGame = false
        timerRunning = true
        winner = ""
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
    
    func checkWinning()  {
        let playerPoint = playerCards.calculateTotalValue()
        let dealerPoint = dealerCards.calculateTotalValue()
        if (playerCards.isAA() && dealerCards.isAA())  || (playerCards.isBlackJack() && dealerCards.isBlackJack()){
            timerRunning = false
            withAnimation(Animation.linear(duration: 0.3)) {
                self.animating.toggle()
            }
            winner = "dealer"
            isEndGame = true
        } else if playerCards.isAA() || dealerCards.isAA() {
            timerRunning = false
            withAnimation(Animation.linear(duration: 0.3)) {
                self.animating.toggle()
            }
            if dealerCards.isAA() {
                winner = "dealer"
            } else {
                winner = "player"
            }
            isEndGame = true
        } else if playerCards.isBlackJack() || dealerCards.isBlackJack(){
            timerRunning = false
            withAnimation(Animation.linear(duration: 0.3)) {
                self.animating.toggle()
            }
            if dealerCards.isBlackJack() {
                winner = "dealer"
            } else {
                winner = "player"
            }
            isEndGame = true
        } else if isPlayerStand && isDealerStand {
            if playerCards.isMagicFive() && dealerCards.isMagicFive(){
                timerRunning = false
                withAnimation(Animation.linear(duration: 0.3)) {
                    self.animating.toggle()
                }
                if dealerCards.calculateTotalValue() < playerCards.calculateTotalValue() {
                    winner = "dealer"
                } else if dealerCards.calculateTotalValue() == playerCards.calculateTotalValue() {
                    winner = "tie"
                } else {
                    winner = "player"
                }
                isEndGame = true
            } else if playerCards.isMagicFive() || dealerCards.isMagicFive(){
                timerRunning = false
                withAnimation(Animation.linear(duration: 0.3)) {
                    self.animating.toggle()
                }
                if dealerCards.isMagicFive() {
                    winner = "dealer"
                } else {
                    winner = "player"
                }
                isEndGame = true
            } else if 16 <= playerPoint && playerPoint <= 21 && dealerPoint <= 21 && dealerPoint >= 16 {
                timerRunning = false
                withAnimation(Animation.linear(duration: 0.3)) {
                    self.animating.toggle()
                }
                if dealerPoint > playerPoint {
                    winner = "dealer"
                } else if dealerPoint == playerPoint{
                    winner = "tie"
                } else {
                    winner = "player"
                }
                isEndGame = true
            } else if (16 <= playerPoint && playerPoint <= 21) || (dealerPoint <= 21 && dealerPoint >= 16) {
                timerRunning = false
                withAnimation(Animation.linear(duration: 0.3)) {
                    self.animating.toggle()
                }
                if dealerPoint <= 21 && dealerPoint >= 16 {
                    winner = "dealer"
                } else {
                    winner = "player"
                }
                isEndGame = true
            } else if playerPoint > 21 || dealerPoint > 21 {
                if dealerPoint > 21 {
                    winner = "dealer"
                } else {
                    winner = "player"
                }
            } else {
                
                timerRunning = false
                withAnimation(Animation.linear(duration: 0.3)) {
                    self.animating.toggle()
                }
                winner = "tie"
                isEndGame = true
            }
        }
    }
    var body: some View {
        ZStack{
            Color.black.edgesIgnoringSafeArea(.all)
            Capsule()
                .strokeBorder(.white, lineWidth: 20)
                .background(Capsule().fill(ColorConstants.shinyGold))
                .overlay(Image("dark-logo-no-background").resizable().scaledToFit().scaleEffect(0.3))
                .frame(width: (UIScreen.main.bounds.width - 100),height: (UIScreen.main.bounds.height - 90))
            ZStack{
                if !isEndGame {
                    Button(action: {
                        if isPlayerTurn && playerCards.calculateTotalValue() < 21 {
                            self.drawCard(isPlayer: true)
                            if isDealerStand {
                                self.endTurn()
                            }
                            
                        }
                    }, label: {
                        Image("hidden")
                    })
                } else {
                    VStack {
                        Button(action: {
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
                            isLinkActive = true
                        }, label: {
                            Capsule()
                                .fill(Color.black)
                                .padding(8)
                                .frame(width: 200, height:50)
                                .overlay(Text("Exit")
                                    .font(.system(.title3, design: .rounded))
                                    .fontWeight(.bold)
                                    .foregroundColor(ColorConstants.boldGold))
                        }).offset(x: CGFloat(200)).background(                        NavigationLink(destination: MenuView(), isActive: $isLinkActive) {
                            Text("")
                    }.hidden()
)
                    }
                    
                }
                ZStack{
                    
                    ZStack{
                        ZStack {
                            Image("player")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .offset(x: CGFloat(-200),y:CGFloat(120))
                            Image("dealer")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .offset(x: CGFloat(-200),y:CGFloat(-120))
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
                            
                            if !isEndGame {
                                Circle()
                                    .trim(from: 0.0, to: self.fill)
                                    .stroke(lineWidth: 8).frame(width: 80, height: 80)
                                    .foregroundColor(Color.green)
                                    .rotationEffect(.init(degrees: -90))
                                    .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                                    .offset(x: CGFloat(-200),y:CGFloat(timerY))
                                    .onReceive(timer){ _ in
                                        if  countDownTimer > 0 && timerRunning {
                                            countDownTimer -= 1
                                            fill -= 1.0/30.0
                                            let randomTime = Int.random(in: 2...28)
                                            if !isPlayerTurn && countDownTimer <= (30 - randomTime) {
                                                let dealerPoints = dealerCards.calculateTotalValue()
                                                if dealerPoints <= 11 {
                                                    self.drawCard(isPlayer: false)
                                                    if isPlayerStand{
                                                        self.endTurn()
                                                    }
                                                    
                                                } else if dealerPoints < 18 {
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
                                                } else {
                                                    isDealerStand = true
                                                    self.endTurn()
                                                    if isPlayerStand {
                                                        checkWinning()
                                                    }
                                                }
                                            }
                                        } else {
                                            self.endTurn()
                                        }
                                    }
                            }
                        }
                        ZStack {
                            PlayCards(isPlayer: true, scaleDealer: $scaleDealer, scalePlayer: $scalePlayer, positionXDealer: $positionXDealer, positionYDealer: $positionYDealer, positionXPlayer: $positionXPlayer, positionYPlayer: $positionYPlayer, playerCards: $playerCards, dealerCards: $dealerCards, showImagePlayer: $showImagePlayer, showImageDealer: $showImageDealer, isImageFlipped: $isEndGame)
                            
                            PlayCards(isPlayer: false, scaleDealer: $scaleDealer, scalePlayer: $scalePlayer, positionXDealer: $positionXDealer, positionYDealer: $positionYDealer, positionXPlayer: $positionXPlayer, positionYPlayer: $positionYPlayer, playerCards: $playerCards, dealerCards: $dealerCards, showImagePlayer: $showImagePlayer, showImageDealer: $showImageDealer, isImageFlipped: $isImageFlipped)
                                .rotation3DEffect(.degrees(rotation), axis: (x: 0, y: 1, z: 0))
                                .onAppear {
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
                        if isPlayerTurn && !isEndGame {
                            Button(action: {
                                if playerCards.calculateTotalValue() > 11 {
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
            AppDelegate.orientationLock = UIInterfaceOrientationMask.landscape
            UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation")
            UINavigationController.attemptRotationToDeviceOrientation()
            playerCards.cards.append(shuffledCards[0])
            shuffledCards.remove(at: 0)
            playerCards.cards.append(shuffledCards[0])
            shuffledCards.remove(at: 0)
            dealerCards.cards.append(shuffledCards[0])
            shuffledCards.remove(at: 0)
            dealerCards.cards.append(shuffledCards[0])
            shuffledCards.remove(at: 0)
            checkWinning()
        }.onDisappear(perform: {
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



struct TableView_Previews: PreviewProvider {
    static var previews: some View {
        TableView().previewInterfaceOrientation(.landscapeLeft)
    }
}

