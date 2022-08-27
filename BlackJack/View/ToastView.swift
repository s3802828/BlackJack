/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Le Quynh Giang
  ID: s3802828
  Created  date: 17/08/2022
  Last modified: 19/08/2022
  Acknowledgement:
 P.Hudson. "Triggering events repeatedly using a timer". Hacking with Swift. https://www.hackingwithswift.com/books/ios-swiftui/triggering-events-repeatedly-using-a-timer (accessed Aug. 17, 2022)
*/

import SwiftUI

struct ToastView: View {
    let timer = Timer.publish(every: 1, on: .current, in: .common).autoconnect()
    let message : String
    @State var countDownTimer : Int
    @State private var isShow = true
    var body: some View {
        //Dismiss the view when the count down timer ends
        if isShow {
            Text("\(message)")
                .foregroundColor(Color.white)
                .padding(20)
                .background(Capsule().opacity(0.5))
                .onReceive(timer){ _ in
                    if  countDownTimer > 0 {
                        countDownTimer -= 1
                    } else {
                        isShow = false
                    }
                }
        }
        
    }
}
