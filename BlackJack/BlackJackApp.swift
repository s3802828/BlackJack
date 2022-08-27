/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Le Quynh Giang
  ID: s3802828
  Created  date: 11/08/2022
  Last modified: 18/08/2022
  Acknowledgement:
 birdmichael. "How to lock screen orientation for a specific view?" developer.apple.com. https://developer.apple.com/forums/thread/128830 (accessed Aug. 18, 2022)
*/

import SwiftUI

@main
struct BlackJackApp: App {
    //Get the adaptor to lock the orientation
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
class AppDelegate: NSObject {
    //Default value is portrait
    static var orientationLock = UIInterfaceOrientationMask.portrait

}

extension AppDelegate: UIApplicationDelegate {
    //The orientation mode that user want to lock for specific view
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {

        return AppDelegate.orientationLock

    }

}
