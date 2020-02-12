# dotLottie-ios

[![CI Status](https://img.shields.io/travis/whit3hawks/dotLottie-ios.svg?style=flat)](https://travis-ci.org/whit3hawks/dotLottie-ios)
[![Version](https://img.shields.io/cocoapods/v/dotLottie-ios.svg?style=flat)](https://cocoapods.org/pods/dotLottie-ios)
[![License](https://img.shields.io/cocoapods/l/dotLottie-ios.svg?style=flat)](https://cocoapods.org/pods/dotLottie-ios)
[![Platform](https://img.shields.io/cocoapods/p/dotLottie-ios.svg?style=flat)](https://cocoapods.org/pods/dotLottie-ios)

## Introducing dotLottie

<p align="center">
  <img src="/_Images/dotLottie_image.png" width="400">
</p>

dotLottie is an open-source file format that aggregates one or more Lottie files and their associated resources into a single file. They are ZIP archives compressed with the Deflate compression method and carry the file extension of ".lottie".

## View documentation, FAQ, help, examples, and more at [dotlottie.io](http://dotlottie.io/)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

dotLottie-ios is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'dotLottie-ios', :git => 'https://github.com/dotlottie/dotlottie-ios.git'
```

## Using dotLottie
```ruby
import Lottie
import dotLottie
```
##### Load a local .lottie
```swift
let animationView = AnimationView()

DotLottieAnimation().load(name: "animation"){ (animation) in
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
```

##### Load a remote .lottie
```swift
let animationView = AnimationView()

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
``` 

##### Load a .lottie using file path
```swift
let animationView = AnimationView()

DotLottieAnimation().load(filePath: URL(string:"path/to/file")!){ (animation) in
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
``` 

## Author

[whit3hawks](https://twitter.com/whit3hawks) <br />
[Sofwath](https://twitter.com/sofwath)

## License

dotLottie-ios is available under the MIT license. See the LICENSE file for more info.
