//
//  HowToPlayView.swift
//  BlackJack
//
//  Created by Giang Le on 16/08/2022.
//

import SwiftUI

struct HowToPlayView: View {
    @Environment(\.dismiss) var dismiss
    let introduction = "This is a simpler version of Vietnamese Blackjack game where there are only draw and stand actions. The dealer could not check the player's cards; therefore, in each round, the player and dealer would take turns drawing the cards until both stand. The total value of taken cards must not exceed 21; otherwise, it would automatically lose"
    let concepts = ["Double Aces (AA)": "Two Ace Cards",
                    "Blackjack": "1 Ace Card with 1 Card of either 10, J, Q, K",
                    "Magic Five" : "5 Cards with total value less than 21",
                    "Dirty Stand": "Stand when total value of cards is less than 16",
                    "Bust": "Total value of cards is over 21",
                    "Safe Range": "Total value is between 16 and 21"]
    let cardValue = ["A": "either 1, 10, or 11", "2 to 10": "corresponding value", "J, Q, K" : "10"]
    let action = ["Draw": "Get more cards (by tapping the card button in the middle of the table)",
                  "Stand": "Stop drawing card (by tapping the \"Stand\" button"]
    let generalRule = "Player would play with the dealer. In the first round, each person would be given 2 cards. The system would check whether at least one person got Double Aces or Blackjack and identify winner if any. If there is not any Double Aces or Blackjack, the game is continued. Player and dealer would take turns drawing at most 3 cards for each person until both decide to stand. At this point, the total value of each person's cards is compared to each other and the result is given. Both the player and dealer are not allowed to draw more cards if they are already busted and to stand if their cards' total value is under 11."
    let scoreRule = [1: "If both got AA or both got Blackjack, the dealer wins, the player would lose the bet",
                     2: "If the player got AA, the dealer didn't, the player would win double of the bet. Otherwise, if the dealer got AA, the player didn't, the player would lose double of the bet.",
                     3: "If the player got Blackjack, the dealer didn't, the player would win the bet. Otherwise, if the dealer got Blackjack, the player didn't, the player would lose the bet.",
                     4: "If both have stood and both got Magic Five, the person with less total value would win. If that is the player, they would win the bet; otherwise, they would lose the bet.",
                     5: "If only one got Magic Five, that person would win. If that is the player, they would win the bet; otherwise, they would lose the bet.",
                     6: "If both got the total value in Safe Range, the person with less total value would win. If that is the player, they would win the bet; otherwise, they would lose the bet.",
                     7: "If only one the total value in Safe Range, that person would win. If that is the player, they would win the bet; otherwise, they would lose the bet.",
                     8: "If one got busted and one got Dirty Stand, the busted person would win. If that is the player, they would win the bet; otherwise, they would lose the bet.",
                     9: "If both got busted or both got Dirty Stand, the result is tie, the player wouldn't lose any money"]
    var body: some View {
        ScrollView{
            ZStack{
                ColorConstants.lightGold.edgesIgnoringSafeArea(.all)
                VStack (alignment: .leading, spacing: 20){
                    HStack {
                        Button(action: {
                            dismiss()
                        }) {
                            Image(systemName: "xmark.circle")
                                .font(.title)
                                .foregroundColor(Color.black)
                        }
                        Text("HOW TO PLAY VBLACKJACK").modifier(HeaderModifier())
                    }
                    Text(introduction).modifier(TextDetailModifier())
                    HStack (alignment: .top){
                        Text("Card Value:").modifier(TitleModifier())
                        VStack (alignment: .leading, spacing:  5){
                            ForEach(cardValue.sorted(by: <), id: \.key) { key,value in
                                HStack (alignment: .top){
                                    Text("\(key):").modifier(SubTitleModifier())
                                    Text(value).modifier(TextDetailModifier())
                                }
                            }
                        }
                    }
                    HStack (alignment: .top){
                        Text("Concepts:").modifier(TitleModifier())
                        VStack (alignment: .leading, spacing:  5){
                            ForEach(concepts.sorted(by: <), id: \.key) { key,value in
                                HStack (alignment: .top){
                                    Text("\(key):").modifier(SubTitleModifier())
                                    Text(value).modifier(TextDetailModifier())
                                }
                            }
                        }
                    }
                    HStack (alignment: .top){
                        Text("Actions:").modifier(TitleModifier())
                        VStack (alignment: .leading, spacing:  5){
                            ForEach(action.sorted(by: <), id: \.key) { key,value in
                                HStack (alignment: .top){
                                    Text("\(key):").modifier(SubTitleModifier())
                                    Text(value).modifier(TextDetailModifier())
                                }
                            }
                        }
                    }
                    Text("General Rule:").modifier(TitleModifier())
                    Text(generalRule).modifier(TextDetailModifier())
                    Text("Scoring Calculation Rule (the priority is as order below): ").modifier(TitleModifier())
                    VStack (alignment: .leading, spacing:  5){
                        ForEach(scoreRule.sorted(by: <), id: \.key) { key,value in
                            HStack (alignment: .top){
                                Text("\(String(key)).").modifier(SubTitleModifier())
                                Text(value).modifier(TextDetailModifier())
                            }
                        }
                    }
                }.padding(.top, 40)
                .padding(.horizontal, 20)
            }.cornerRadius(25.0)
        }
    }
}

struct HowToPlayView_Previews: PreviewProvider {
    static var previews: some View {
        HowToPlayView()
    }
}
