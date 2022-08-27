/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Le Quynh Giang
  ID: s3802828
  Created  date: 17/08/2022
  Last modified: 18/08/2022
  Acknowledgement:
    Apple Developer Documentation. "Picker". https://developer.apple.com/documentation/swiftui/picker/. (accessed Aug. 17, 2022)
*/

import SwiftUI

struct SettingView: View {
    @State var betSelection = UserDefaults.standard.integer(forKey: "betAmount")
    @State var timeLimit = UserDefaults.standard.integer(forKey: "timeLimit")
    var bet = [1, 10, 20, 50, 100, 200, 500]
    var time = [15, 30, 45]
    var coin : Int
    @State var betAmountValid = true
    //MARK: VALIDATE BET AMOUNT
    func validateBetAmount() {
        if betSelection > coin {
            betAmountValid = false
        } else {
            betAmountValid = true
            UserDefaults.standard.set(betSelection, forKey: "betAmount")
        }
    }
    var body: some View {
        NavigationView {
            ZStack {
                Form {
                    Section(header: Text("Time Limit")) {
                        Picker("Time Limit", selection: $timeLimit) {
                            ForEach(time, id: \.self) {
                                Text(String($0))
                            }
                        }.onChange(of: timeLimit) { _ in
                            UserDefaults.standard.set(timeLimit, forKey: "timeLimit")
                        }.pickerStyle(SegmentedPickerStyle())
                    }
                    Section(header: Text("Bet Amount")) {
                        Picker("Bet Amount", selection: $betSelection) {
                            ForEach(bet, id: \.self) {
                                Text(String($0))
                            }
                        }.onChange(of: betSelection) { _ in
                            playSound2(sound: "betMoney", type: "wav")
                            validateBetAmount()
                        }.pickerStyle(SegmentedPickerStyle())
                    }
                }
                
                
                if !betAmountValid {
                    ToastView(message: "You cannot bet more than your current coins!", countDownTimer: 2)
                        .onDisappear(){
                            betSelection = 1
                            UserDefaults.standard.set(betSelection, forKey: "betAmount")
                        }
                }
            }.navigationBarTitle(Text("SETTINGS"), displayMode: .inline)
            
        }
    }
}

