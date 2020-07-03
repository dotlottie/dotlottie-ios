//
//  DotLottieSettings.swift
//  dotLottie
//
//  Created by Evandro Harrison Hoffmann on 03/07/2020.
//

import SwiftUI
import Lottie

/// Settings for dot lottie animation view
public struct DotLottieSettings {
    public var name: String?
    public var url: URL?
    public var aspectRatio: UIView.ContentMode = .scaleAspectFit
    public var autoPlay: Bool = false
    public var loopMode: LottieLoopMode = .playOnce
    public var speed: CGFloat = 1
    public var completionHandler: LottieCompletionBlock?
    
    /// Initializes Settings with file name
    /// - Parameters:
    ///   - name: local file name
    ///   - aspectRatio: Animation Aspect ratio
    ///   - autoPlay: true for start playing upon setup
    ///   - loopMode: loop mode
    ///   - speed: playback speed
    ///   - completionHandler: to be called upon completed
    public init(name: String,
                aspectRatio: UIView.ContentMode = .scaleAspectFit,
                autoPlay: Bool = false,
                loopMode: LottieLoopMode = .playOnce,
                speed: CGFloat = 1,
                completionHandler: LottieCompletionBlock? = nil) {
        self.name = name
        self.aspectRatio = aspectRatio
        self.autoPlay = autoPlay
        self.loopMode = loopMode
        self.speed = speed
        self.completionHandler = completionHandler
    }
    
    /// Initializes Settings with url
    /// - Parameters:
    ///   - url: url to animation
    ///   - aspectRatio: Animation Aspect ratio
    ///   - autoPlay: true for start playing upon setup
    ///   - loopMode: loop mode
    ///   - speed: playback speed
    ///   - completionHandler: to be called upon completed
    public init(url: URL, aspectRatio: UIView.ContentMode = .scaleAspectFit,
                autoPlay: Bool = false,
                loopMode: LottieLoopMode = .playOnce,
                speed: CGFloat = 1,
                completionHandler: LottieCompletionBlock? = nil) {
        self.url = url
        self.aspectRatio = aspectRatio
        self.autoPlay = autoPlay
        self.loopMode = loopMode
        self.speed = speed
        self.completionHandler = completionHandler
    }
}
