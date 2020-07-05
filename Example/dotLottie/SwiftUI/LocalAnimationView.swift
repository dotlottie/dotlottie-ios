//
//  LocalAnimationView.swift
//  dotLottie_Example
//
//  Created by Evandro Harrison Hoffmann on 03/07/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import SwiftUI
import dotLottie

struct LocalAnimationView: View {
    @State var title: String
    @State var name: String
    @Binding var play: Int
    
    var body: some View {
        VStack {
            Text(title).font(.headline)
            
            DotLottieView(name: name, play: self.$play, onCompleted: { completed in
                print("\(self.title) \(completed ? "completed" : "paused")")
            }).frame(height:200)
        }
        .padding(20)
        .border(Color.black, width: 1)
    }
}

struct LocalAnimationView_Previews: PreviewProvider {
    @State static var play: Int = 0
    static var previews: some View {
        LocalAnimationView(title: "Local json file", name: "globe", play: $play)
    }
}
