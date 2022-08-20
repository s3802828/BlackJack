//
//  Modifiers.swift
//  BlackJack
//
//  Created by Giang Le on 16/08/2022.
//

import Foundation
import SwiftUI

struct HeaderModifier: ViewModifier{
    func body(content: Content) -> some View {
      content
            .font(.system(size: 20.0, weight: .heavy))
            .frame(minWidth: 0, maxWidth: UIScreen.main.bounds.width, alignment: .center)
            .foregroundColor(Color.black)
    }
}
struct TitleModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
        .font(.system(size: 15, weight: .bold))
        .foregroundColor(Color.black)
  }
}

struct SubTitleModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
        .font(.system(size: 12.5, weight: .semibold))
        .foregroundColor(Color.black)
  }
}

struct TextDetailModifier: ViewModifier {
    func body(content: Content) -> some View {
      content
        .font(.system(size: 12.5))
        .foregroundColor(Color.black)
    }
}

struct IconButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
      content
        .foregroundColor(ColorConstants.boldGold)
        .font(.system(size: 25.0))
    }
}
