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
    @State var isStart = false
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
                        if isPlayerTurn {
                            showImagePlayer.append(true)
                            positionXPlayer.append(0)
                            positionYPlayer.append(0)
                            scalePlayer.append(0.5)
                            playerCards.cards.append(shuffledCards[0])
                            shuffledCards.remove(at: 0)
                            for i in 0..<showImagePlayer.count - 1 {
                                positionXPlayer[i] -= 30
                            }
                            isPlayerTurn.toggle()
                            timerY *= -1
                            fill = 1.0
                            timerRunning = false
                            countDownTimer = 30
                            timerRunning = true
                        }
                    }, label: {
                        Image("hidden")
                    })
                } else {
                    Button(action: {
                        isEndGame = false
                        timerRunning = true
                        winner = ""
                        playerCards.cards.removeAll()
                        dealerCards.cards.removeAll()
                        shuffledCards = cardDeck
                        playerCards.cards.append(shuffledCards[0])
                        shuffledCards.remove(at: 0)
                        playerCards.cards.append(shuffledCards[0])
                        shuffledCards.remove(at: 0)
                        dealerCards.cards.append(shuffledCards[0])
                        shuffledCards.remove(at: 0)
                        dealerCards.cards.append(shuffledCards[0])
                        shuffledCards.remove(at: 0)
                        isStart = true
                        
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
                }
                ZStack{
                    if isStart {
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
                                    ResultBadge(isWinner: true)
                                        .scaleEffect(CGFloat(scaleWinner))
                                        .offset(x: CGFloat(-200),y: winner == "player" ? CGFloat(120) : CGFloat(-120))
                                        .onAppear(){
                                            let baseAnimation = Animation.easeInOut(duration: 1)
                                            let repeated = baseAnimation.repeatCount(1) //Only play the animation once
                                            withAnimation(repeated){
                                                scaleWinner = 1.0
                                            }
                                        }
                                    ResultBadge(isWinner: false)
                                        .scaleEffect(CGFloat(scaleLoser))
                                        .offset(x: CGFloat(-200),y: winner == "player" ? CGFloat(-120) : CGFloat(120))
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
                                                if !isPlayerTurn && countDownTimer <= 25 {
                                                    showImageDealer.append(true)
                                                    positionXDealer.append(0)
                                                    positionYDealer.append(0)
                                                    scaleDealer.append(0.5)
                                                    dealerCards.cards.append(shuffledCards[0])
                                                    shuffledCards.remove(at: 0)
                                                    for i in 0..<showImageDealer.count - 1 {
                                                        positionXDealer[i] -= 30
                                                    }
                                                    isPlayerTurn.toggle()
                                                    timerY *= -1
                                                    fill = 1.0
                                                    timerRunning = false
                                                    countDownTimer = 30
                                                    timerRunning = true
                                                }
                                            } else {
                                                isPlayerTurn.toggle()
                                                fill = 1.0
                                                timerY *= -1
                                                timerRunning = false
                                                countDownTimer = 30
                                                timerRunning = true
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
                            
                            
                        }
                    }
                }
            }.onAppear(){
                playerCards.cards.append(shuffledCards[0])
                shuffledCards.remove(at: 0)
                playerCards.cards.append(shuffledCards[0])
                shuffledCards.remove(at: 0)
                dealerCards.cards.append(shuffledCards[0])
                shuffledCards.remove(at: 0)
                dealerCards.cards.append(shuffledCards[0])
                shuffledCards.remove(at: 0)
                isStart = true
                if playerCards.isAA() || dealerCards.isAA() {
                    isEndGame = true
                    isStart = false
                    timerRunning = false
                    withAnimation(Animation.linear(duration: 0.3)) {
                        self.animating.toggle()
                    }
                    if playerCards.isAA() {
                        winner = "player"
                    } else {
                        winner = "dealer"
                    }
                }
            }
        }
    }
    struct ResultBadge : View {
        var isWinner: Bool
        var body: some View{
            ZStack{
                Image(isWinner ? "winner-badge" : "loser-badge")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
            }
            
        }
    }
    
    struct PlayCards : View {
        var isPlayer : Bool
        @Binding var scaleDealer : [Float]
        @Binding var scalePlayer : [Float]
        @Binding var positionXDealer: [Int]
        @Binding var positionYDealer:[Int]
        @Binding var positionXPlayer: [Int]
        @Binding var positionYPlayer:[Int]
        @Binding var playerCards: CardArray
        @Binding var dealerCards: CardArray
        @Binding var showImagePlayer: [Bool]
        @Binding var showImageDealer: [Bool]
        @Binding var isImageFlipped : Bool
        var body: some View{
            if isPlayer{
                ForEach(0..<playerCards.cards.count, id: \.self) { i in
                    if (showImagePlayer[i]) {
                        Image(playerCards.cards[i].name)
                            .scaleEffect(CGFloat(scalePlayer[i]))
                            .offset(x: CGFloat(positionXPlayer[i]), y: CGFloat(positionYPlayer[i]))
                            .onAppear(){
                                let baseAnimation = Animation.easeInOut(duration: 1)
                                let repeated = baseAnimation.repeatCount(1) //Only play the animation once
                                withAnimation(repeated){
                                    scalePlayer[i] = 1.0
                                    positionXPlayer[i] += 30
                                    positionYPlayer[i] += 120
                                }
                            }
                    }
                }
            } else {
                if !isImageFlipped {
                    ForEach(0..<dealerCards.cards.count, id: \.self) { i in
                        if (showImageDealer[i]) {
                            Image("hidden")
                                .scaleEffect(CGFloat(scaleDealer[i]))
                                .offset(x: CGFloat(positionXDealer[i]), y: CGFloat(positionYDealer[i]))
                                .onAppear(){
                                    let baseAnimation = Animation.easeInOut(duration: 1)
                                    let repeated = baseAnimation.repeatCount(1) //Only play the animation once
                                    withAnimation(repeated){
                                        scaleDealer[i] = 1.0
                                        positionXDealer[i] += 30
                                        positionYDealer[i] -= 120
                                    }
                                }
                        }
                    }
                } else {
                    ForEach(0..<dealerCards.cards.count, id: \.self) { i in
                        if (showImageDealer[i]) {
                            Image(dealerCards.cards[i].name)
                                .scaleEffect(CGFloat(scaleDealer[i]))
                                .offset(x: CGFloat(positionXDealer[i]), y: CGFloat(positionYDealer[i]))
                                .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                        }
                    }
                }
                
            }
            
        }
    }
    
    struct TableView_Previews: PreviewProvider {
        static var previews: some View {
            TableView().previewInterfaceOrientation(.landscapeLeft)
            //        CreditCardFlip()
        }
    }
}
