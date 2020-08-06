//
//  DotLottieManifest.swift
//  LottieFiles
//
//  Created by Evandro Harrison Hoffmann on 27/06/2020.
//  Copyright © 2020 LottieFiles. All rights reserved.
//

import Foundation

/// Manifest model for .lottie File
public struct dotLottieManifest: Decodable {
    public var animations: [DotLottieAnimation]
    public var version: String
    public var author: String
    public var generator: String
    
    /// Decodes data to Manifest model
    /// - Parameter data: Data to decode
    /// - Throws: Error
    /// - Returns: .lottie Manifest model
    public static func decode(from data: Data) throws -> dotLottieManifest? {
        return try? JSONDecoder().decode(dotLottieManifest.self, from: data)
    }

    /// Loads manifest from given URL
    /// - Parameter path: URL path to Manifest
    /// - Returns: Manifest Model
    public static func load(from url: URL) throws -> dotLottieManifest? {
        guard let data = try? Data(contentsOf: url) else { return nil }
        return try? decode(from: data)
    }
}

/// Animation model for .lottie File
public struct DotLottieAnimation: Decodable {
    public var loop: Bool
    public var themeColor: String
    public var speed: Float
    public var id: String
}
