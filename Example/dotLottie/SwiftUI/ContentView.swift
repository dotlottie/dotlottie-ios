//
//  ContentView.swift
//  dotLottie_Example
//
//  Created by Evandro Harrison Hoffmann on 03/07/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import SwiftUI
import dotLottie

struct ContentView: View {
    @State var play: Int = 0
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 50) {
                    LocalAnimationView(title: "Local .lottie", name: "lottie", play: $play)
                    LocalAnimationView(title: "Local .json", name: "globe", play: $play)
                    RemoteAnimationView(title: "Remote .lottie file", url: URL(string: "https://dotlottie.io/sample_files/animation.lottie")!, play: $play)
                    RemoteAnimationView(title: "Remote .json file", url: URL(string: "https://assets9.lottiefiles.com/packages/lf20_2gjZuP.json")!, play: $play)
                }
            }
            Button("Toggle play"){ self.play = self.play == 1 ? 0 : 1 }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
