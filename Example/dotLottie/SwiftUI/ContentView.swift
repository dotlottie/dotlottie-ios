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
    @State var play: Bool = false
    @ObservedObject var viewModel: ContentViewModel
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 50) {
                    ForEach(viewModel.animations) { animation in
                        VStack {
                            Text(animation.title)
                                .font(.headline)
                            DotLottieView(with: animation.settings, play: self.$play)
                                .frame(height:200)
                        }
                        .padding(20)
                        .border(Color.black, width: 1)
                    }
                }
            }
            Button(play ? "Pause" : "Play"){ self.play = !self.play }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ContentViewModel())
    }
}
