//
//  DotLottieAnimation.swift
//  dotLottie-ios
//
//  Created by whit3hawks on 02/07/2020.
//  Copyright (c) 2020 whit3hawks. All rights reserved.
//
import Foundation
import CoreGraphics
import Lottie
import dotLottieLoader

public typealias LottieFile = DotLottieFile
public typealias DotLottieResponse = (Animation?, LottieFile?) -> Void

public class DotLottie {
    
    /// Enables log printing
    public static var isLogEnabled: Bool {
        get {
            DotLottieUtils.isLogEnabled
        }
        set {
            DotLottieUtils.isLogEnabled = newValue
        }
    }
    
    /// Prints log if enabled
    /// - Parameter text: Text to log
    public static func log(_ text: String) {
        guard isLogEnabled else { return }
        print("[DotLottie] \(text)")
    }
    
    /// Loads animation in bundle with given name
    /// - Parameters:
    ///   - name: name of animation in bundle
    ///   - cache: Cache type   
    ///   - completion: Lottie Animation
    public static func load(name: String, cache:
        DotLottieCache = .cache, completion: @escaping DotLottieResponse) {
        DotLottieLoader.load(name: name, cache: cache) { (dotLottieFile) in
            if let dotLottieFile = dotLottieFile {
                animation(lottie: dotLottieFile, completion: completion)
            } else if let url = DotLottieUtils.bundleURL(for: name) {
                animation(for: url, completion: completion)
            }
        }
    }
    
    /// Loads an animation from a URL
    /// If it's a remote .lottie file, we download, unzip and extract the animation
    /// For .json files, we simply show the animation
    /// - Parameters:
    ///   - url: url to load animation from
    ///   - cache: Cache type
    ///   - completion: Lottie Animation
    public static func load(from url: URL, cache: DotLottieCache = .cache, completion: @escaping DotLottieResponse) {
        DotLottieLoader.load(from: url, cache: cache) { (dotLottieFile) in
            if let dotLottieFile = dotLottieFile {
                animation(lottie: dotLottieFile, completion: completion)
            } else {
                animation(for: url, completion: completion)
            }
        }
    }
    
    /// Loads Lottie animation with url to JSON file
    /// - Parameters:
    ///   - url: url to load animation from
    ///   - completion: Lottie animation
    public static func animation(for url: URL, completion: @escaping DotLottieResponse) {
        guard url.isJsonFile else {
            DotLottieUtils.log("""
                    Not a JSON file, instead use:
                    DotLottieAnimation.load(from: URL, completion: (Animation?) -> Void)
                  """)
            completion(nil, nil)
            return
        }
        
        Animation.loadedFrom(url: url, closure: { (animation) in
            completion(animation, nil)
        }, animationCache: LRUAnimationCache.sharedCache)
    }
    
    /// Loads Lottie animation with lottie object
    /// - Parameters:
    ///   - lottie: lottie object
    ///   - completion: Lottie animation
    public static func animation(lottie: DotLottieFile, completion: @escaping DotLottieResponse) {
        guard let url = lottie.animations.first, url.isJsonFile else {
            DotLottieUtils.log("""
                    Not a JSON file, instead use:
                    DotLottieAnimation.load(from: URL, completion: (Animation?, DotLottieFile) -> Void)
                  """)
            completion(nil, lottie)
            return
        }
        
        Animation.loadedFrom(url: url, closure: { (animation) in
            completion(animation, lottie)
        }, animationCache: LRUAnimationCache.sharedCache)
    }
}
