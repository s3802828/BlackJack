//
//  MenuView.swift
//  BlackJack
//
//  Created by Giang Le on 16/08/2022.
//

import SwiftUI

struct MenuView: View {
    @Environment(\.colorScheme) var colorScheme
    @State var scale = 0.5 //Used to control the scale of view when doing the animation
    @State var showGameView = false
    @State private var showingHowToPlay = false
    @State private var showingSetting = false
    @State private var showLeaderBoard = false
    @State var loggedInUser : [String: Any] = [:]
    @State var isGuest = true
    var body: some View {
            ZStack{
                colorScheme == .dark ? Color.white.edgesIgnoringSafeArea(.all) : Color.black.edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20){
                    HStack {
                        Button(action: {
                            showingSetting = true
                        }, label: {
                            Image(systemName: "gearshape.fill")
                                .modifier(IconButtonModifier())
                                
                        }).sheet(isPresented: $showingSetting){
                            SettingView(coin: loggedInUser.count == 0 ? 500 : loggedInUser["currentCoin"] as! Int)
                        }
                        Button(action: {
                            showingHowToPlay = true
                        }, label: {
                            Image(systemName: "questionmark.circle.fill")
                                .modifier(IconButtonModifier())
                                
                        }).sheet(isPresented: $showingHowToPlay){
                            HowToPlayView()
                        }
                        Button(action: {
                            showLeaderBoard = true
                        }, label: {
                            Image(systemName: "chart.bar.xaxis")
                                .modifier(IconButtonModifier())
                                
                        }).sheet(isPresented: $showLeaderBoard){
                            LeaderBoardView()
                        }
                    }.padding(.trailing, 20)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                    Spacer()
                    //MARK: APP ICON & NAME
                    Image("color-logo-no-background")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(minWidth: 0 , maxWidth: .infinity)
                    //Add animation for the app logo
                        .scaleEffect(scale)
                        .onAppear{
                            let baseAnimation = Animation.easeInOut(duration: 1)
                            let repeated = baseAnimation.repeatCount(1) //Only play the animation once
                            withAnimation(repeated){
                                //Zoom in the app icon and app name by change the scale from 0.5 to 1.0
                                scale = 1.0
                            }
                        }
                    
                    
                    Spacer()
                    if isGuest {
                        RegisterView(isGuest: $isGuest, loggedInUser: $loggedInUser)
                            .padding(10)
                    } else {
                        VStack {
                            Button(action: {
                                showGameView = true
                            }, label: {
                                Capsule()
                                    .fill(ColorConstants.boldGold)
                                    .padding(8)
                                    .frame(height:80)
                                    .overlay(Text("START GAME")
                                        .font(.system(.title3, design: .rounded))
                                        .fontWeight(.bold)
                                        .foregroundColor(.black))
                            }).fullScreenCover(isPresented: $showGameView){
                                TableView(loggedInUser: $loggedInUser)
                            }
                            Button(action: {
                                isGuest = true
                                loggedInUser = [:]
                            }, label: {
                                Capsule()
                                    .fill(ColorConstants.boldGold)
                                    .padding(8)
                                    .frame(height:80)
                                    .overlay(Text("CHANGE ACCOUNT")
                                        .font(.system(.title3, design: .rounded))
                                        .fontWeight(.bold)
                                        .foregroundColor(.black))
                            })
                        }
                        
                    }
                    Spacer()
                    //MARK: FOOTER MARK
                    Text("@RMIT University Vietnam 2022").foregroundColor(ColorConstants.boldGold)
                }
            }.onAppear(){
                if UserDefaults.standard.integer(forKey: "betAmount") == 0 {
                    UserDefaults.standard.set(1, forKey: "betAmount")
                }
                if UserDefaults.standard.integer(forKey: "timeLimit") == 0 {
                    UserDefaults.standard.set(30, forKey: "timeLimit")
                }
                if UserDefaults.standard.array(forKey: "userInfo") == nil {
                    UserDefaults.standard.set([], forKey: "userInfo")
                }
                playSound(sound: "welcome", type: "mp3")
            }.onDisappear(){
                stopPlayer()
            }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
