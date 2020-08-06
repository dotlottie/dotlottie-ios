# dotLottieLoader

[![CI Status](https://img.shields.io/travis/eharrison/dotLottieLoader.svg?style=flat)](https://travis-ci.org/eharrison/dotLottieLoader)
[![Version](https://img.shields.io/cocoapods/v/dotLottieLoader.svg?style=flat)](https://cocoapods.org/pods/dotLottieLoader)
[![License](https://img.shields.io/cocoapods/l/dotLottieLoader.svg?style=flat)](https://cocoapods.org/pods/dotLottieLoader)
[![Platform](https://img.shields.io/cocoapods/p/dotLottieLoader.svg?style=flat)](https://cocoapods.org/pods/dotLottieLoader)

## Introducing dotLottie

<p align="center">
  <img src="/Example/dotLottie/Assets/Images.xcassets/AppIcon.appiconset/dotLottie2048-1024.png" width="400">
</p>

dotLottie is an open-source file format that aggregates one or more Lottie files and their associated resources into a single file. They are ZIP archives compressed with the Deflate compression method and carry the file extension of ".lottie".

### dotLottieLoader

dotLottieLoader is a library to help downloading and deflating a .lottie file, giving access to the animationUrl as well as included images.

## View documentation, FAQ, help, examples, and more at [dotlottie.io](http://dotlottie.io/)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

### Cocoapods

dotLottieLoader-ios is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```swift
pod 'dotLottieLoader', :git => 'https://github.com/dotlottie/dotlottieLoader-ios.git'
```

### Swift Package Manager

```swift
.package(url: "https://github.com/dotlottie/dotLottieLoader-ios.git", from: "0.1.4")
```

## Using dotLottie
```swift=
import dotLottieLoader
```

##### Enabling log
```swift
dotLottieUtils.isLogEnabled = true
```

##### Loading from a local file

```swift
dotLottieLoader.load(name: "animation") { (dotLottieFile) in
    // use dotLottieLoader.animationUrl to load the lottie animation as you normally would
}
```

##### Loading a remote file

```swift
dotLottieLoader.load(from: URL(string:"https://dotlottie.io/sample_files/animation.lottie")!){ (dotLottieFile) in
    // use dotLottieLoader.animationUrl to load the lottie animation as you normally would
}
``` 

## Author

[Evandro Harrison Hoffmann](https://github.com/eharrison) | evandro.hoffmann@gmail.com

## License

dotLottieLoader-ios is available under the MIT license. See the LICENSE file for more info.
