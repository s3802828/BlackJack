//
//  ContentView.swift
//  BlackJack
//
//  Created by Giang Le on 11/08/2022.
//

import SwiftUI
struct ContentView: View {
    var body: some View {
        MenuView()
            .onAppear(){
            AppDelegate.orientationLock = UIInterfaceOrientationMask.portrait
            UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
            UINavigationController.attemptRotationToDeviceOrientation()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
