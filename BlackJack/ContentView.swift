/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Le Quynh Giang
  ID: s3802828
  Created  date: 11/08/2022
  Last modified: 23/08/2022
  Acknowledgement:
 P.Hudson. "How to detect when your app moves to the background or foreground with scenePhase" Hacking with Swift. https://www.hackingwithswift.com/quick-start/swiftui/how-to-detect-when-your-app-moves-to-the-background-or-foreground-with-scenephase (accessed Aug. 23, 2022)
*/

import SwiftUI
struct ContentView: View {
    //Get the view mode with environment object
    @Environment(\.scenePhase) var scenePhase
    var body: some View {
        MenuView().onChange(of: scenePhase) { newPhase in
            //If the view is inactive or in the background
            if newPhase == .inactive ||  newPhase == .background {
                //Pause all of the playing sound
                pausePlayer()
                pausePlayer2()
            } else if newPhase == .active { //If the view is active again,
                //Resume the player
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
