//
//  ToastView.swift
//  BlackJack
//
//  Created by Giang Le on 17/08/2022.
//

import SwiftUI

struct ToastView: View {
    let timer = Timer.publish(every: 1, on: .current, in: .common).autoconnect()
    let message : String
    @State var countDownTimer : Int
    @State private var isShow = true
    var body: some View {
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
