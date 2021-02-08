//
//  DotLottieAnimation.swift
//  dotLottie-ios
//
//  Created by Evandro Hoffmann on 05/08/2020.
//  Copyright (c) 2020 dotLottie. All rights reserved.
//
import Foundation

public class DotLottieLoader {
    
    /// Loads JSON in bundle with given name
    /// - Parameters:
    ///   - name: name of animation in bundle
    ///   - cache: Cache type
    ///   - completion: dotLottieFile
    public static func load(name: String, cache: DotLottieCache = .cache, completion: @escaping (DotLottieFile?) -> Void) {
        if let url = DotLottieUtils.bundleURL(for: name) {
            completion(DotLottieFile(url: url, cache: cache))
        } else {
            completion(nil)
        }
    }
    
    /// Loads an animation from a URL
    /// If it's a remote .lottie file, we download, unzip and extract the animation
    /// For .json files, we simply show the animation
    /// - Parameters:
    ///   - url: url to load animation from
    ///   - cache: Cache type
    ///   - completion: dotLottieFile
    public static func load(from url: URL, cache: DotLottieCache = .cache, completion: @escaping (DotLottieFile?) -> Void) {
        if url.isDotLottieFile {
            download(from: url, cache: cache) { (dotLottieFile) in
                completion(dotLottieFile)
            }
        } else {
            DotLottieUtils.log("Not a dotLottieFile")
            completion(nil)
        }
    }
    
    /// Downloads file from given URL and save in local app temp folder
    /// - Parameters:
    ///   - url: remote url to download file from
    ///   - cache: Cache type
    ///   - completion: dotLottieFile
    public static func download(from url: URL, cache: DotLottieCache, completion: @escaping (DotLottieFile?) -> Void) {
        // file is not remote, so just read
        guard url.isRemoteFile else {
            DotLottieUtils.log("Local file [\(url.lastPathComponent)], trying to read")
            completion(DotLottieFile(url: url, cache: cache))
            return
        }
        
        // file is already either downloaded or decompressed, we don't need to proceed
        guard cache.shouldDownload(from: url) else {
            DotLottieUtils.log("Skipping download for [\(url.lastPathComponent)], trying to read instead")
            completion(DotLottieFile(url: DotLottieUtils.downloadsDirectoryURL(for: url), cache: cache))
            return
        }
        
        DotLottieUtils.log("Downloading from url: \(url.path)")
        URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            guard let data = data else {
                DotLottieUtils.log("Failed to download data: \(error?.localizedDescription ?? "no description")")
                completion(nil)
                return
            }
            
            do {
                try FileManager.default.createDirectory(at: DotLottieUtils.downloadsDirectoryURL, withIntermediateDirectories: true, attributes: nil)
                let downloadUrl = DotLottieUtils.downloadsDirectoryURL(for: url)
                try data.write(to: downloadUrl)
                
                DotLottieUtils.log("Downloaded file, trying to read")
                completion(DotLottieFile(url: downloadUrl, cache: cache))
            } catch {
                DotLottieUtils.log("Failed to save downloaded data: \(error.localizedDescription)")
                completion(nil)
            }
        }).resume()
    }
}
