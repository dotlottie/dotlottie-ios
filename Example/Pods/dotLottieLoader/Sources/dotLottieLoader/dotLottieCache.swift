//
//  DotLottieCache.swift
//  dotLottie
//
//  Created by Evandro Harrison Hoffmann on 05/07/2020.
//

import Foundation

public enum DotLottieCache {
    /// ignores any existing cache and download/decompress again
    case ignoreCache
    
    /// checks for local cache before downloading/decompressing
    case cache
    
    /// Returns true if should proceed with download
    /// - Parameter url: url to download from
    /// - Returns: Bool
    func shouldDownload(from url: URL) -> Bool {
        switch self {
        case .ignoreCache:
            return url.isRemoteFile
        case .cache:
            return !url.isLottieFileDownloaded
        }
    }
    
    /// Returns true if should proceed with decompression
    /// - Parameter url: url to download from
    /// - Returns: Bool
    func shouldDecompress(from url: URL) -> Bool {
        switch self {
        case .ignoreCache:
            return true
        case .cache:
            return !url.isLottieFileDecompressed
        }
    }
}
