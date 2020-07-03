//
//  ContentViewModel.swift
//  dotLottie_Example
//
//  Created by Evandro Harrison Hoffmann on 03/07/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import dotLottie

class ContentViewModel: ObservableObject {
    @Published var animations: [MyAnimation]
    
    init() {
        animations = [
            .init(title: "Local .lottie file",
                  settings: .init(name: "lottie",
                                  loopMode: .loop)),
            .init(title: "Local .json file",
                  settings: .init(name: "globe",
                                  loopMode: .loop)),
            .init(title: "Remote .lottie file",
                  settings: .init(url: URL(string: "https://dotlottie.io/sample_files/animation.lottie")!,
                                  loopMode: .loop)),
            .init(title: "Remote .json file",
                  settings: .init(url: URL(string: "https://assets9.lottiefiles.com/packages/lf20_2gjZuP.json")!,
                                  loopMode: .loop))
        ]
    }
}

struct MyAnimation: Identifiable {
    let id: UUID = .init()
    let title: String
    let settings: DotLottieSettings
}
