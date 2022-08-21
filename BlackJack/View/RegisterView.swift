//
//  RegisterView.swift
//  BlackJack
//
//  Created by Giang Le on 18/08/2022.
//

import SwiftUI

struct RegisterView: View {
    @State var username = ""
    @State var password = ""
    var userArray: [Dictionary<String, Any>] = UserDefaults.standard.array(forKey: "userInfo") as? [Dictionary<String, Any>] ?? [];
    @State var isPasswordValid = true
    @Binding var isGuest : Bool
    @Binding var loggedInUser : [String: Any]
    
    func validateAuth() {
        isPasswordValid = true
        for i in userArray {
            if i["username"] as! String == username  && i["password"] as! String == password {
                isPasswordValid = true
                isGuest = false
                loggedInUser = i
                return;
            } else if i["username"] as! String == username {
                isPasswordValid = false
                return;
            }
        }
        let newUserArray = userArray + [["username": username, "password": password, "highestCoin": 500, "currentCoin": 500]]
        UserDefaults.standard.set(newUserArray, forKey: "userInfo")
        isGuest = false
        loggedInUser = ["username": username, "password": password, "highestCoin": 500, "currentCoin": 500]
    }
    var body: some View {
        ZStack {
            VStack {
                TextField("Username", text: $username)
                    .disableAutocorrection(true)
                SecureField("Password", text: $password)
                    .disableAutocorrection(true)
                Button(action: {
                    validateAuth()
                }, label: {
                    Capsule()
                        .fill(ColorConstants.boldGold)
                        .padding(8)
                        .frame(height:80)
                        .overlay(Text("SUBMIT")
                            .font(.system(.title3, design: .rounded))
                            .fontWeight(.bold)
                            .foregroundColor(.black))
                })
            }.textFieldStyle(.roundedBorder)
            if !isPasswordValid {
                ToastView(message: "If you are signing up, this username is already used, please enter another one. If you are logging in, the password is incorrect, please re-enter the correct one.", countDownTimer: 2)
                    .onDisappear(){
                    isPasswordValid = true
                }
            }
        }
    }
}
