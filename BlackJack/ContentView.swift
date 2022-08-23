//
//  ContentView.swift
//  BlackJack
//
//  Created by Giang Le on 11/08/2022.
//

import SwiftUI
struct ContentView: View {
    @Environment(\.scenePhase) var scenePhase
    var body: some View {
        MenuView().onChange(of: scenePhase) { newPhase in
            if newPhase == .inactive ||  newPhase == .background {
                pausePlayer()
                pausePlayer2()
            } else if newPhase == .active {
                resumePlayer()
                resumePlayer2()
            }
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
