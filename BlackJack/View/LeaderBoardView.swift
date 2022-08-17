//
//  LeaderBoardView.swift
//  BlackJack
//
//  Created by Giang Le on 18/08/2022.
//

import SwiftUI

struct LeaderBoardView: View {
    let userArray = UserDefaults.standard.array(forKey: "userInfo")
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct LeaderBoardView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderBoardView()
    }
}
