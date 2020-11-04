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
    
    var name: String?
    var url: URL?
    var aspectRatio: UIView.ContentMode = .scaleAspectFit
    var autoPlay: Bool = false
    var loopMode: LottieLoopMode = .playOnce
    var speed: CGFloat = 1
    var completionHandler: LottieCompletionBlock?
    @Binding var play: Int
    
    public var animationView = AnimationView()
    
    /// Initializes AnimationView with file name
    /// - Parameters:
    ///   - name: local file name
    ///   - aspectRatio: Animation Aspect ratio
    ///   - autoPlay: true for start playing upon setup
    ///   - loopMode: loop mode
    ///   - speed: playback speed
    ///   - play: play binding
    ///   - onCompleted: Fired when animation has completed
    public init(name: String,
                aspectRatio: UIView.ContentMode = .scaleAspectFit,
                autoPlay: Bool = false,
                loopMode: LottieLoopMode = .playOnce,
                speed: CGFloat = 1,
                play: Binding<Int>,
                onCompleted: LottieCompletionBlock? = nil) {
        self.name = name
        self.aspectRatio = aspectRatio
        self.autoPlay = autoPlay
        self.loopMode = loopMode
        self.speed = speed
        self._play = play
        self.completionHandler = onCompleted
    }
    
    /// Initializes AnimationView with url
    /// - Parameters:
    ///   - url: local file name
    ///   - aspectRatio: Animation Aspect ratio
    ///   - autoPlay: true for start playing upon setup
    ///   - loopMode: loop mode
    ///   - speed: playback speed
    ///   - play: play binding
    ///   - onCompleted: Fired when animation has completed
    public init(url: URL,
                aspectRatio: UIView.ContentMode = .scaleAspectFit,
                autoPlay: Bool = false,
                loopMode: LottieLoopMode = .playOnce,
                speed: CGFloat = 1,
                play: Binding<Int>,
                onCompleted: LottieCompletionBlock? = nil) {
        self.url = url
        self.aspectRatio = aspectRatio
        self.autoPlay = autoPlay
        self.loopMode = loopMode
        self.speed = speed
        self._play = play
        self.completionHandler = onCompleted
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
        let view = UIView()
        
        if let name = name {
            DotLottie.load(name: name) { (animation, lottie) in
                setupAnimationView(animation, lottie)
            }
        } else if let url = url {
            DotLottie.load(from: url) { (animation, lottie) in
                setupAnimationView(animation, lottie)
            }
        }

        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.removeFromSuperview()
        view.addSubview(animationView)

        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        return view
    }
    
    /// Setup animation view with given Lottie Animation
    /// - Parameter animation: Lottie Animation
    public func setupAnimationView(_ animation: Lottie.Animation?, _ lottie: LottieFile?) {
        animationView.animation = animation
        animationView.contentMode = aspectRatio
        animationView.loopMode = loopMode
        animationView.animationSpeed = speed
        
        if let url = lottie?.images.first {
            animationView.imageProvider = FilepathImageProvider(filepath: url)
        }
        
        if autoPlay {
            animationView.play(completion: completionHandler)
        }
    }
    
    /// update view with binders
    /// - Parameters:
    ///   - uiView: content view to update
    ///   - context: UIViewRepresentableContext
    public func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<DotLottieView>) {
        if animationView.isAnimationPlaying {
            animationView.pause()
        } else {
            animationView.play(completion: completionHandler)
        }
    }
}
