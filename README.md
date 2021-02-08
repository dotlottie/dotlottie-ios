# dotLottie-ios

[![CI Status](https://img.shields.io/travis/whit3hawks/dotLottie-ios.svg?style=flat)](https://travis-ci.org/whit3hawks/dotLottie-ios)
[![Version](https://img.shields.io/cocoapods/v/dotLottie-ios.svg?style=flat)](https://cocoapods.org/pods/dotLottie-ios)
[![License](https://img.shields.io/cocoapods/l/dotLottie-ios.svg?style=flat)](https://cocoapods.org/pods/dotLottie-ios)
[![Platform](https://img.shields.io/cocoapods/p/dotLottie-ios.svg?style=flat)](https://cocoapods.org/pods/dotLottie-ios)

## Introducing dotLottie

<p align="center">
  <img src="/Example/dotLottie/Assets/Images.xcassets/AppIcon.appiconset/dotLottie2048-1024.png" width="400">
</p>

dotLottie is an open-source file format that aggregates one or more Lottie files and their associated resources into a single file. They are ZIP archives compressed with the Deflate compression method and carry the file extension of ".lottie".

## View documentation, FAQ, help, examples, and more at [dotlottie.io](http://dotlottie.io/)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- Swift 5.0
- iOS 9
- macOS 10.12
- tvOS 10.0

## Installation

### Cocoapods

dotLottie-ios is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```swift
pod 'dotLottie'
```

### Swift Package Manager

```swift
.package(url: "https://github.com/dotlottie/dotlottie-ios.git", from: "0.1.7")
```

## Using dotLottie
```swift
import Lottie
import dotLottie
```

##### Enabling log
```swift
DotLottie.isLogEnabled = true
```

##### Loading from a local file

```swift
let animationView = AnimationView()

DotLottie.load(name: "animation") { (animation) in
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

##### Loading a remote file

```swift
let animationView = AnimationView()

DotLottie.load(from: URL(string:"https://dotlottie.io/sample_files/animation.lottie")!){ (animation) in
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

#### SwiftUI

##### Loading a local file

```swift
import SwiftUI
import dotLottie

struct LocalAnimationView: View {
    @State var name: String
    @State var play: Int = 1
    
    var body: some View {
        DotLottieView(name: name, play: self.$play, onCompleted: { completed in
            // handle completion
        })
        .frame(height:200)
    }
}
``` 

##### Loading file from a remote source

```swift
import SwiftUI
import dotLottie

struct RemoteAnimationView: View {
    @State var url: URL
    @State var play: Int = 1
    
    var body: some View {
        DotLottieView(url: url, play: self.$play, onCompleted: { completed in
            // handle completion
        })
        .frame(height:200)
    }
}
``` 

## Author

[Evandro Harrison Hoffmann](https://github.com/eharrison) | evandro.hoffmann@gmail.com

## License

dotLottie-ios is available under the MIT license. See the LICENSE file for more info.
