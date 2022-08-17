//
//  ToastView.swift
//  BlackJack
//
//  Created by Giang Le on 17/08/2022.
//

import SwiftUI

struct ToastView: View {
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let message : String
    @State private var countDownTimer = 1
    @State private var isShow = true
    var body: some View {
        if isShow {
            Text("\(message)")
                .foregroundColor(Color.white)
                .padding(10)
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

struct ToastView_Previews: PreviewProvider {
    static var previews: some View {
        ToastView(message: "Hello")
    }
}
