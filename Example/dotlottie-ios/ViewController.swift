//
//  ViewController.swift
//  dotlottie-ios
//
//  Created by whit3hawks on 02/12/2020.
//  Copyright (c) 2020 whit3hawks. All rights reserved.
//

import UIKit
import Lottie
import dotLottie

class ViewController: UIViewController {
    
    let animationView = AnimationView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Load .lottie files using file path
        // replace DotLottieAnimation().load(from: URL(string:"")!)
        // with DotLottieAnimation().load(filePath: URL(string: "file/to/path")!)
        
        // Load local .lottie files
        // replace DotLottieAnimation().load(from: URL(string:"")!)
        // with DotLottieAnimation().load(name: "pushups")
        
        DotLottieAnimation().load(from: URL(string:"https://dotlottie.io/sample_files/animation.lottie")!){ (animation) in
            if let animation = animation {
                self.animationView.animation = animation
                self.animationView.bounds = CGRect(x: 0, y: 0, width: 300, height: 300)
                self.animationView.center = self.view.center
                
                self.view.addSubview(self.animationView)
                self.animationView.play()
            }else{
               print("Error loading .lottie")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

