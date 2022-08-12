//
//  TableView.swift
//  BlackJack
//
//  Created by Giang Le on 12/08/2022.
//

import SwiftUI

struct TableView: View {
    @State var scale : [Float] = [0.5]
    @State var positionX: [Int] = [0]
    @State var positionY:[Int] = [0]
    @State var showImage: [Bool] = []
    @State var index: [Int] = []
    @State var count = 0
    var body: some View {
        ZStack{
            Color.black.edgesIgnoringSafeArea(.all)
            ZStack{
                Button(action: {
                    showImage.append(false)
                    positionX.append(0)
                    positionY.append(0)
                    scale.append(0.5)
                    showImage[count] = true
                    index.append(count)
                    for i in 0...count {
                        positionX[i] -= 30
                    }
                    count += 1
                }, label: {
                    Capsule()
                        .fill(Color.white)
                        .padding(8)
                        .frame(height:80)
                        .overlay(Text("Go Explore")
                            .font(.system(.title3, design: .rounded))
                            .fontWeight(.bold)
                            .foregroundColor(.black))
                })
                ZStack{
                    Image(cards[0].name)
                        .scaleEffect(CGFloat(scale[0]))
                        .offset(x: CGFloat(positionX[0]), y: CGFloat(positionY[0]))
                        .onAppear(){
                            let baseAnimation = Animation.easeInOut(duration: 1)
                            let repeated = baseAnimation.repeatCount(1) //Only play the animation once
                            withAnimation(repeated){
                                //Zoom in the app icon and app name by change the scale from 0.5 to 1.0
                                scale[0] = 1.0
                                positionY[0] += 100
                            }
                        }
                    ForEach(index, id: \.self) { i in
                        if (showImage[i]) {
                            Image(cards[i+1].name)
                                .scaleEffect(CGFloat(scale[i+1]))
                                .offset(x: CGFloat(positionX[i+1]), y: CGFloat(positionY[i+1]))
                                .onAppear(){
                                    let baseAnimation = Animation.easeInOut(duration: 1)
                                    let repeated = baseAnimation.repeatCount(1) //Only play the animation once
                                    withAnimation(repeated){
                                        //Zoom in the app icon and app name by change the scale from 0.5 to 1.0
                                        scale[i+1] = 1.0
                                        positionY[i+1] += 100
                                    }
                                }
                        }
                    }
                }
            }
        }
    }
}

struct TableView_Previews: PreviewProvider {
    static var previews: some View {
        TableView().previewInterfaceOrientation(.landscapeLeft)
    }
}
