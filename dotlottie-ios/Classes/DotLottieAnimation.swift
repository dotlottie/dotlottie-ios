//
//  DotLottieAnimation.swift
//  dotLottie-ios
//
//  Created by whit3hawks on 02/07/2020.
//  Copyright (c) 2020 whit3hawks. All rights reserved.
//
import Foundation
import CoreGraphics
import Zip
import Lottie

var lottieImages = "?"
public class DotLottieAnimation{
    
    struct Manifest: Decodable {
        var animations: [Ani]
        var version : String
        var author: String
        var generator: String
    }
    struct Ani : Decodable {
        var loop: Bool
        var themeColor: String
        var speed: Float
        var id : String
    }
    
    public init() {}

    func decode(data: Data) throws -> Manifest? {
        do {
            let decoder = JSONDecoder()
            let user = try decoder.decode(Manifest.self, from: data)
            return user
        } catch let error {
            print(error)
            return nil
        }
    }

    func loadManifest(path:URL) -> Manifest? {
        do {
            let content = try Data(contentsOf: path)
            let user = try decode(data: content)
            return user

        } catch let error {
            print(error)
            return nil
        }
    }
    
    func loadURL(name:String) -> URL?{
        guard let dotLottieURL = Bundle.main.url(forResource: name, withExtension: "lottie", subdirectory: nil) else {
            guard let dotLottieURL = Bundle.main.url(forResource: name, withExtension: "json", subdirectory: nil) else {
                return nil
            }
            return dotLottieURL
        }
        return dotLottieURL
    }

    func loadDotLottie(dotLottieUrl:URL) -> URL? {
        if dotLottieUrl.pathExtension == "lottie" {
            Zip.addCustomFileExtension("lottie")
            // unzip to tmp
            let tmpDirURL : URL
            if #available(iOS 10.0, *) {
              tmpDirURL = FileManager.default.temporaryDirectory
            } else {
              tmpDirURL = URL(fileURLWithPath: NSTemporaryDirectory())
            }

            do {
              try Zip.unzipFile(dotLottieUrl, destination: tmpDirURL, overwrite: true, password: "", progress: { (progress) -> () in
                  //print(progress)
              }) // Unzip
            } catch {
              print("Extraction of dotLottie archive failed with error:\(error)")
            }
            let manifestfile = "manifest.json"
            let path = tmpDirURL.appendingPathComponent(manifestfile)
            let dd = loadManifest(path:path)
            let animationId = (dd?.animations[0].id)!
            let dotLottieJson = "animations/"+animationId + ".json"
            let url = tmpDirURL.appendingPathComponent(dotLottieJson)
            // set the image provider to dotLottie images
            let imgDir = "images/"
            let imageProvider = tmpDirURL.appendingPathComponent(imgDir)
            lottieImages = imageProvider.absoluteString
            return url
        }else{
            return dotLottieUrl
        }
    }
    
    func downloadDotLottie(url: URL, completion: @escaping (_ filePath: String) -> Void) {
        URLSession.shared.dataTask(with:url, completionHandler: { data, response, error in
            guard let data = data, error == nil, let _ = response else { return }
            if let filePath = self.saveToDocumentDirectory(data: data, url: url) {
               completion(filePath)
            }
        }).resume()
    }
    
    private func saveToDocumentDirectory(data: Data, url: URL) -> String? {
        let fileName = url.lastPathComponent
        guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL else {
            return nil
        }
        
        do {
            try data.write(to: directory.appendingPathComponent(fileName)!)
            return directory.appendingPathComponent(fileName)?.relativeString
        } catch {
            print("\(#function)" + error.localizedDescription)
            return nil
        }
    }
    
    public func load(name:String, completion: @escaping (Animation?) -> Void){
        if let url = loadURL(name: name) {
            if let url = self.loadDotLottie(dotLottieUrl: url) {
                Animation.loadedFrom(url: url, closure: { (animation) in
                    completion(animation)
                }, animationCache: .none)
            }else{
                completion(nil)
            }
        }else{
            completion(nil)
        }
    }
    
    public func load(filePath:URL, completion: @escaping (Animation?) -> Void){
        if let url = self.loadDotLottie(dotLottieUrl: filePath) {
            Animation.loadedFrom(url: url, closure: { (animation) in
                completion(animation)
            }, animationCache: .none)
        }else{
            completion(nil)
        }
    }
    
    public func load(from:URL, completion: @escaping (Animation?) -> Void){
        if from.absoluteString.contains("http") {
            downloadDotLottie(url: from){ (filePath) in
                if let url = URL(string: filePath){
                    if let url = self.loadDotLottie(dotLottieUrl: url) {
                        Animation.loadedFrom(url: url, closure: { (animation) in
                            completion(animation)
                        }, animationCache: .none)
                    }else{
                        completion(nil)
                    }
                }
            }
        } else {
            completion(nil)
        }
    }
    
    
}
