//
//  Card.swift
//  BlackJack
//
//  Created by Giang Le on 12/08/2022.
//

import Foundation

import SwiftUI


struct Card: Identifiable{
    var id = UUID()
    var name: String
    var value: [Int]
    var image: Image {
        Image(name)
    }
}

struct CardArray: Identifiable{
    var id = UUID()
    var cards: [Card] = []
    func isBlackJack() -> Bool {
        return cards.count == 2 && (cards[0].name.last! == "A" && ["0", "J", "Q", "K"].contains(cards[1].name.last!) || cards[1].name.last! == "A" && ["0", "J", "Q", "K"].contains(cards[0].name.last!))
    }
    func isAA() -> Bool {
        return cards.count == 2 && cards[0].name.last! == "A" && cards[1].name.last! == "A"
    }
    func isMagicFive() -> Bool {
        return cards.count == 5 && self.calculateTotalValue(isEndGame: false) <= 21
    }
    
    func calculateTotalValue(isEndGame: Bool) -> Int {
        var total = 0
        let sortedCard = cards.sorted(by: {$0.value.count < $1.value.count})
        var index = 0
        for i in sortedCard {
            if i.value.count > 1 {
                if !isEndGame {
                    total += 1
                } else {
                    if index < sortedCard.count - 1 {
                        total += 1
                    } else {
                        let sortedValue = i.value.sorted(by: <)
                        var difference = 21 - (total + sortedValue[0])
                        var chosenValue = sortedValue[0]
                        var idx = 1
                        while difference > 0 && idx < sortedValue.count {
                            if 21 - (total + sortedValue[idx]) < difference {
                                let prevDifference = difference
                                difference = 21 - (total + sortedValue[idx])
                                if difference >= 0 || difference < 0 && prevDifference > 5 {
                                    chosenValue = sortedValue[idx]
                                }
                            }
                            idx += 1
                        }
                        total += chosenValue
                    }
                }
            } else {
                total += i.value[0]
            }
            index += 1
        }
        return total
    }
}
