//
//  ViewController.swift
//  dotLottie
//
//  Created by eharrison on 06/28/2020.
//  Copyright (c) 2020 eharrison. All rights reserved.
//

import UIKit
import Lottie
import dotLottie

class ViewController: UIViewController {
    
    @IBOutlet weak var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stackView.arrangedSubviews.forEach({ $0.removeFromSuperview() })
        
        // Load .lottie files using file path
        // replace DotLottie.load(from: URL(string:"")!)
        // with DotLottie.load(from: URL(string: "file/to/path")!)
        
        // Load local .lottie files
        // replace DotLottie.load(from: URL(string:"")!)
        // with DotLottie.load(name: "pushups")
        
        DotLottie.load(from: URL(string:"https://dotlottie.io/sample_files/animation.lottie")!) { [weak self] (animation) in
            guard let animation = animation else {
                print("Error loading animation")
                return
            }
            
            self?.setupAnimation(animation, title: "Remote .lottie file")
        }
        
        DotLottie.load(from: URL(string:"https://assets9.lottiefiles.com/packages/lf20_2gjZuP.json")!) { [weak self] (animation) in
            guard let animation = animation else {
                print("Error loading animation")
                return
            }
            
            self?.setupAnimation(animation, title: "Remote JSON file")
        }
        
        DotLottie.load(name: "lottie") { [weak self] (animation) in
            guard let animation = animation else {
                print("Error loading animation")
                return
            }
            
            self?.setupAnimation(animation, title: "Local .lottie file")
        }
        
        DotLottie.load(name: "globe") { [weak self] (animation) in
            guard let animation = animation else {
                print("Error loading animation")
                return
            }
            
            self?.setupAnimation(animation, title: "Local JSON file")
        }
    }
    
    private func setupAnimation(_ animation: Animation, title: String) {
        let label = UILabel()
        label.textColor = .black
        label.text = title
        label.font = .systemFont(ofSize: 20)
        label.textAlignment = .center
        stackView.addArrangedSubview(label)
        
        let animationView = AnimationView(animation: animation)
        animationView.loopMode = .loop
        
        stackView.addArrangedSubview(animationView)
        animationView.play()
        
        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalToConstant: 200),
            label.heightAnchor.constraint(equalToConstant: 25)
        ])
    }

}

