//
//  DotLottieView.swift
//  dotLottie
//
//  Created by Evandro Harrison Hoffmann on 03/07/2020.
//
import SwiftUI
import Lottie

@available(iOS 13.0, *)
public struct DotLottieView: UIViewRepresentable {
    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    public var settings: DotLottieSettings
    @Binding public var play: Bool
    
    public var animationView = AnimationView()
    
    /// Initializes AnimationView with file name
    /// - Parameters:
    ///   - settings: animation settings
    ///   - play: play binding
    public init(with settings: DotLottieSettings, play: Binding<Bool>) {
        self.settings = settings
        self._play = play
    }
    
    /// View coordinator
    public class Coordinator: NSObject {
        public var parent: DotLottieView
    
        public init(_ animationView: DotLottieView) {
            self.parent = animationView
            super.init()
        }
    }
    
    /// Make view and load animation
    /// - Parameter context: UIViewRepresentableContext
    /// - Returns: UIView
    public func makeUIView(context: UIViewRepresentableContext<DotLottieView>) -> UIView {
        if let name = settings.name {
            DotLottie.load(name: name, completion: setupAnimationView(_:))
        } else if let url = settings.url {
            DotLottie.load(from: url, completion: setupAnimationView(_:))
        }

        return containerView()
    }
    
    /// Initialize container view and adds constraints
    /// - Returns: Container view
    private func containerView() -> UIView {
        let view = UIView()
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)

        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        return view
    }
    
    /// Setup animation view with given Lottie Animation
    /// - Parameter animation: Lottie Animation
    public func setupAnimationView(_ animation: Lottie.Animation?) {
        animationView.animation = animation
        animationView.contentMode = settings.aspectRatio
        animationView.loopMode = settings.loopMode
        animationView.animationSpeed = settings.speed
        
        if settings.autoPlay {
            animationView.play(completion: settings.completionHandler)
        }
    }
    
    /// update view with binders
    /// - Parameters:
    ///   - uiView: content view to update
    ///   - context: UIViewRepresentableContext
    public func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<DotLottieView>) {
        if play {
            animationView.play()
        } else {
            animationView.pause()
        }
    }
}
