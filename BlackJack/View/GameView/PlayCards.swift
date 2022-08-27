/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Le Quynh Giang
  ID: s3802828
  Created  date: 15/08/2022
  Last modified: 24/08/2022
  Acknowledgement:
    T.Huynh."RMIT-Casino/RMIT Casino/Views/ReelView.swift".GitHub.https://github.com/TomHuynhSG/RMIT-Casino/blob/main/RMIT%20Casino/Views/ReelView.swift. (accessed Aug. 16, 2022)
 */

import SwiftUI

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
            //player track whether game ended or not
            if !isImageFlipped {
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
                ForEach(0..<playerCards.cards.count, id: \.self) { i in
                    if (showImagePlayer[i]) {
                        Image(playerCards.cards[i].name)
                            .scaleEffect(1.0)
                            .offset(x: CGFloat(positionXPlayer[i]), y: 120)
                    }
                }
            }
        } else {
            //dealer track whether image flipped or not
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
