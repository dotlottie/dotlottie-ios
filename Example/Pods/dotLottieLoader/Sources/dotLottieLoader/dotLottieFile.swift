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
public struct dotLottieFile {
    public let remoteUrl: URL
    public let localUrl: URL
    
    public static let manifestFileName: String = "manifest.json"
    public static let animationsFolderName: String = "animations"
    public static let imagesFolderName: String = "images"
    
    /// Manifest.json file loading
    public var manifest: dotLottieManifest? {
        let path = localUrl.appendingPathComponent(dotLottieFile.manifestFileName)
        return try? dotLottieManifest.load(from: path)
    }
    
    /// Animation url for main animation
    public var animationUrl: URL? {
        guard let animationId = manifest?.animations.first?.id else { return nil }
        let dotLottieJson = "\(dotLottieFile.animationsFolderName)/\(animationId).json"
        return localUrl.appendingPathComponent(dotLottieJson)
    }
    
    /// Animation images folder url
    public var imagesUrl: URL? {
        return localUrl.appendingPathComponent("\(dotLottieFile.imagesFolderName)/")
    }
    
    /// Constructor with url.
    /// Returns nil if is not a .lottie file and decompression failed
    /// - Parameters:
    ///   - url: URL to .lottie file
    ///   - cache: Cache type 
    public init?(url: URL, cache: dotLottieCache) {
        self.remoteUrl = url
        self.localUrl = dotLottieUtils.animationsDirectoryURL(for: url)
        
        guard url.isDotLottieFile else { return nil }
        guard decompress(from: url, in: localUrl, cache: cache) else { return nil }
    }
    
    /// Decompresses .lottie file and saves to local temp folder
    /// - Parameters:
    ///   - url: url to .lottie file
    ///   - directory: url to destination of decompression contents
    ///   - cache: Cache type   
    /// - Returns: success true/false
    private func decompress(from url: URL, in directory: URL, cache: dotLottieCache) -> Bool {
        guard cache.shouldDecompress(from: url) else {
            dotLottieUtils.log("File already decompressed at \(directory.path)")
            return true
        }
        
        Zip.addCustomFileExtension(dotLottieUtils.dotLottieExtension)
        
        do {
            try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true, attributes: nil)
            try Zip.unzipFile(url, destination: directory, overwrite: true, password: nil)
            dotLottieUtils.log("File decompressed to \(directory.path)")
            return true
        } catch {
            dotLottieUtils.log("Extraction of dotLottie archive failed with error: \(error)")
            return false
        }
    }
    
}
