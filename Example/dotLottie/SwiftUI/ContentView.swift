//
//  ContentView.swift
//  dotLottie_Example
//
//  Created by Evandro Harrison Hoffmann on 03/07/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import SwiftUI
import dotLottie

prefix func !(value: Binding<Bool>) -> Binding<Bool> {
    return Binding<Bool>(get: { return !value.wrappedValue},
                         set: { b in value.wrappedValue = b})
}

struct ContentView: View {
    @State var play: Int = 0
    @ObservedObject var viewModel: ContentViewModel
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 50) {
                    ForEach(viewModel.animations) { animation in
                        VStack {
                            Text(animation.title)
                                .font(.headline)
                            DotLottieView(with: animation.settings, play: self.$play, onCompleted: { completed in
                                print("\(animation.title) \(completed ? "completed" : "paused")")
                            }).frame(height:200)
                        }
                        .padding(20)
                        .border(Color.black, width: 1)
                    }
                }
            }
            Button("Toggle play"){ self.play = self.play == 1 ? 0 : 1 }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ContentViewModel())
    }
}
