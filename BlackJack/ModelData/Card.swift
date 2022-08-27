/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Le Quynh Giang
  ID: s3802828
  Created  date: 11/08/2022
  Last modified: 24/08/2022
  Acknowledgement:
 T.Huynh."SSETContactList/ContactList/Model/Contact.swift".GitHub.https://github.com/TomHuynhSG/SSETContactList/blob/main/ContactList/Model/Contact.swift. (accessed Aug. 11, 2022)
*/

import Foundation

import SwiftUI

//Create a card
struct Card: Identifiable{
    var id = UUID()
    var name: String
    var value: [Int]
    var image: Image {
        Image(name)
    }
}
//Store array of card
struct CardArray: Identifiable{
    var id = UUID()
    var cards: [Card] = []
    //MARK: CHECK BLACKJACK
    func isBlackJack() -> Bool {
        return cards.count == 2 && (cards[0].name.last! == "A" && ["0", "J", "Q", "K"].contains(cards[1].name.last!) || cards[1].name.last! == "A" && ["0", "J", "Q", "K"].contains(cards[0].name.last!))
    }
    //MARK: CHECK AA
    func isAA() -> Bool {
        return cards.count == 2 && cards[0].name.last! == "A" && cards[1].name.last! == "A"
    }
    //MARK: CHECK MAGIC FIVE
    func isMagicFive() -> Bool {
        //This criteria would mark the user with less point is the winner so that to calculate value for this case, the end game would be put false to calculate the total as small as possible
        return cards.count == 5 && self.calculateTotalValue(isEndGame: false) <= 21
    }
    //MARK: CALCULATE TOTAL VALUE
    func calculateTotalValue(isEndGame: Bool) -> Int {
        var total = 0
        //sorted the card by the value array length to push all "A" cards to the end
        let sortedCard = cards.sorted(by: {$0.value.count < $1.value.count})
        var index = 0
        for i in sortedCard {
            //If it's the "A" card
            if i.value.count > 1 {
                //If the game hasn't been ended, the total would be plus 1 so that the user could get the magic five.
                if !isEndGame {
                    total += 1
                } else { //Otherwise,
                    //If there are more than 1 "A" card, all of the "A" card before the final one would be calculated as 1 because if they get 2 cards of AA, the total could be 10 and 11 since that would make the user busted.
                    if index < sortedCard.count - 1 {
                        total += 1
                    } else {
                        //Sort the value array of the "A" card in ascending order
                        let sortedValue = i.value.sorted(by: <)
                        //Get the smallest value
                        var difference = 21 - (total + sortedValue[0])
                        var chosenValue = sortedValue[0]
                        var idx = 1
                        //if the current total with chosen value is less than or equal 21
                        while difference > 0 && idx < sortedValue.count {
                            //if the difference of current one is more near 21
                            if 21 - (total + sortedValue[idx]) < difference {
                                let prevDifference = difference //Store the current difference
                                //set new difference
                                difference = 21 - (total + sortedValue[idx])
                                //if the current total with chosen value is less than or equal 21 or more than 21 but total count is less than 16
                                if difference >= 0 || difference < 0 && prevDifference > 5 {
                                    //Set the chosen value as the current one. This is due to the rule that the user would get win if they got busted and the opponent got dirty stand
                                    chosenValue = sortedValue[idx]
                                }
                            }
                            idx += 1
                        }
                        //add the chosen value to total
                        total += chosenValue
                    }
                }
            } else {
                //if it's not the "A" card, the value of the card would be automatically added to total
                total += i.value[0]
            }
            index += 1
        }
        //return the total value
        return total
    }
}
