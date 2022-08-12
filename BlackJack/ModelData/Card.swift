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
