//
//  BlackJackApp.swift
//  BlackJack
//
//  Created by Giang Le on 11/08/2022.
//

import SwiftUI

@main
struct BlackJackApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
class AppDelegate: NSObject {

    static var orientationLock = UIInterfaceOrientationMask.portrait

}

extension AppDelegate: UIApplicationDelegate {

    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {

        return AppDelegate.orientationLock

    }

}
