# CWRateKit

Create your own rate view controller for feedback from your customers.

<p float="left">
    <img src="https://github.com/clockworkone/CWRateKit/blob/master/Assets/preview-1.gif" width="256">
    <img src="https://github.com/clockworkone/CWRateKit/blob/master/Assets/preview-2.gif" width="256">
</p>

If you like the project, please do not forget to `star ★` this repository and follow me on GitHub.

## Navigate

- [Requirements](#requirements)
- [Installation](#installation)
    - [CocoaPods](#cocoapods)
    - [Swift Package Manager](#swift-package-manager)
    - [Carthage](#carthage)
    - [Manually](#manually)
- [Quick Start](#quick-start)
- [Usage](#usage)
    - [Overlay](#overlay)
    - [Popup](#Popup)
    - [Close Button](#close-button)
    - [Haptic](#haptic)
    - [Marks](#marks)   
    - [Header Image](#header-image)
    - [Submit Button](#submit-button)
    - [Success Text](#success-text)
    - [Delegate](#delegate)
- [Communication](#communication)
- [License](#license)

## Requirements

Swift 5.0

Ready for use on iOS 12+

## Installation

### CocoaPods:

[CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To integrate `CWRateKit` into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
pod 'CWRateKit'
```

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for managing the distribution of Swift code. It’s integrated with the Swift build system to automate the process of downloading, compiling, and linking dependencies.

To integrate `CWRateKit` into your Xcode project using Xcode 11, specify it in `File > Swift Packages > Add`:

```ogdl
https://github.com/clockworkone/CWRateKit
```

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks. To integrate `CWRateKit` into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "clockworkone/CWRateKit"
```

### Manually

If you prefer not to use any of dependency managers, you can integrate `CWRateKit` into your project manually. Put `CWRateKit` folder in your Xcode project. Make sure to enable `Copy items if needed` and `Create groups`.

## Quick Start

```swift
import UIKit
import CWRateKit

class ViewController: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let rateViewController = CWRateKitViewController()
        rateViewController.modalPresentationStyle = .overFullScreen

        present(rateViewController, animated: true, completion: nil)
    }
}
```

## Usage

If you require deep customization, this section will show you what you can do.

### Overlay

```swift
rateViewController.overlayOpacity = 0.0
```

### Popup

```swift
rateViewController.backgroundColor = .white
rateViewController.cornerRadius = 16.0
rateViewController.showShadow = true
rateViewController.tintColor = UIColor(red: 227/255, green: 227/255, blue: 227/255, alpha: 1.0)
rateViewController.animationDuration = 0.5
```

### Close Button
Property `showCloseButton` added circle button with dismiss action.
```swift
rateViewController.showCloseButton = true
```

### Haptic
Property hapticMoments allow add taptic feedback for some moments. Default is `[.willChange, .willSubmit]`:
```swift
rateViewController.hapticMoments = [.willChange, .willSubmit]
```
To disable haptics, set it to `[.none]`

### Marks

```swift
rateViewController.selectedMarkImage = UIImage(named: "star_selected.png")
rateViewController.unselectedMarkImage = UIImage(named: "star_unselected.png")
rateViewController.sizeMarkImage = CGSize(width: 36.0, height: 36.0)
```

### Header Image

```swift
rateViewController.showHeaderImage = false
rateViewController.headerImageIsStatic = true
rateViewController.headerImage = UIImage(named: "headerIamge")
rateViewController.headerImageSize = CGSize(width: 72.0, height: 72.0)
rateViewController.headerImages = [
    UIImage(named: "smile_1"),
    UIImage(named: "smile_2"),
    UIImage(named: "smile_3"),
    UIImage(named: "smile_4"),
    UIImage(named: "smile_5")
]
rateViewController.animationType = .bounce
```

### Submit Button

```swift
rateViewController.confirmRateEnabled = true
rateViewController.submitText = "Submit"
rateViewController.submitTextColor = .black
rateViewController.submitFont = .systemFont(ofSize: 18.0, weight: .medium)
```

### Success Text

```swift
rateViewController.successText = "Thank You!"
rateViewController.successTextColor = .lightGray
rateViewController.successFont = .systemFont(ofSize: 20.0, weight: .regular)
```

### Delegate
Set delegate for rateViewController
```swift
rateViewController.delegate = self
```
You can check events by implement CWRateKitViewControllerDelegate
```swift
extension ViewController: CWRateKitViewControllerDelegate {

    func didChange(rate: Int) {
        print("Current rate is \(rate)")
    }

    func didSubmit(rate: Int) {
        print("Submit with rate \(rate)")
    }
    
    func didDismiss() {
        print("Dismiss the rate view")
    }
    
}
```

## Communication
- If you **need help**, use [Stack Overflow](http://stackoverflow.com/questions/tagged/cwratekit). (Tag 'cwratekit')
- If you **found a bug**, open an issue.
- If you **have a feature request**, open an issue.
- If you **want to contribute**, submit a pull request.

## License
`CWRateKit` is released under the MIT license. Check LICENSE for details.