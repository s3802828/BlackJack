//
//  MenuView.swift
//  BlackJack
//
//  Created by Giang Le on 16/08/2022.
//

import SwiftUI

struct MenuView: View {
    @State var scale = 0.5 //Used to control the scale of view when doing the animation
    @State var isLinkActive = false
    var body: some View {
        NavigationView {
            ZStack{
                ColorConstants.black.ignoresSafeArea(.all, edges: .all)
                
                VStack(spacing: 20){
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
                    
                    Button(action: {
                        isLinkActive = true
                    }, label: {
                        Capsule()
                            .fill(ColorConstants.boldGold)
                            .padding(8)
                            .frame(height:80)
                            .overlay(Text("Go Explore")
                                .font(.system(.title3, design: .rounded))
                                .fontWeight(.bold)
                                .foregroundColor(.black))
                    })
                    .background(
                        NavigationLink(destination: TableView(), isActive: $isLinkActive) {
                                Text("")
                        }.hidden()
                            
                    )
                    Spacer()
                    //MARK: FOOTER MARK
                    Text("@RMIT University Vietnam 2022").foregroundColor(ColorConstants.boldGold)
                }
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
