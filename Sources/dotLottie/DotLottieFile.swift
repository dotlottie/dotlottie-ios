//
//  DotLottieFile.swift
//  LottieFiles
//
//  Created by Evandro Harrison Hoffmann on 27/06/2020.
//  Copyright © 2020 LottieFiles. All rights reserved.
//

import Foundation
import Zip

/// Detailed .lottie file structure
public struct DotLottieFile {
    public let remoteUrl: URL
    public let localUrl: URL
    
    /// Manifest.json file loading
    public var manifest: DotLottieManifest? {
        let manifestfile = "manifest.json"
        let path = localUrl.appendingPathComponent(manifestfile)
        return try? DotLottieManifest.load(from: path)
    }
    
    /// Animation url for main animation
    public var animationUrl: URL? {
        guard let animationId = manifest?.animations.first?.id else { return nil }
        let dotLottieJson = "animations/\(animationId).json"
        return localUrl.appendingPathComponent(dotLottieJson)
    }
    
    /// Animation images folder url
    public var imagesUrl: URL? {
        return localUrl.appendingPathComponent("images/")
    }
    
    /// Constructor with url.
    /// Returns nil if is not a .lottie file and decompression failed
    /// - Parameter url: URL to .lottie file
    public init?(url: URL) {
        self.remoteUrl = url
        self.localUrl = DotLottieUtils.tempDirectoryURL(for: url)
        
        guard url.isDotLottieFile else { return nil }
        guard decompress(from: url, in: localUrl) else { return nil }
    }
    
    /// Decompresses .lottie file and saves to local temp folder
    /// - Parameters:
    ///   - url: url to .lottie file
    ///   - directory: url to destination of decompression contents
    /// - Returns: success true/false
    private func decompress(from url: URL, in directory: URL) -> Bool {
        Zip.addCustomFileExtension(DotLottieUtils.dotLottieExtension)
        
        do {
            try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true, attributes: nil)
            try Zip.unzipFile(url, destination: directory, overwrite: true, password: nil)
            return true
        } catch {
            print("Extraction of dotLottie archive failed with error: \(error)")
            return false
        }
    }
    
}
