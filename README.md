# KHBannerView

[![Version](https://img.shields.io/cocoapods/v/KHBannerView.svg?style=flat)](https://cocoapods.org/pods/KHBannerView)
[![License](https://img.shields.io/cocoapods/l/KHBannerView.svg?style=flat)](https://cocoapods.org/pods/KHBannerView)
[![Platform](https://img.shields.io/cocoapods/p/KHBannerView.svg?style=flat)](https://cocoapods.org/pods/KHBannerView)

**KHBannerView** is a simple infinity carousel that automatically scrolls banners.

---

## 📖 How To Use

* **Swift**
```swift
import KHBannerView

// Set banner Items
let bannerItem: [KHBannerItem] = [
    KHBannerItem(image: UIImage(named: "A")),
    KHBannerItem(image: UIImage(named: "B")),
    KHBannerItem(image: UIImage(named: "C"))
]

// Configure KHBannerView
bannerView.configure(banners: bannerItem)

// Set KHBanner Timer's time interval (Default is 3.0)
bannerView.timeInterval = 4.0

// Set Delegate
bannerView.delegate = self

// KHBannerViewDelegate methods
func banner(bannerView: KHBannerView, didSelect: KHBannerItem, with index: Int) {
    // Handle selection
}

func banner(bannerView: KHBannerView, didScrollTo: KHBannerItem, with index: Int) {
    // Handle scroll
}

```

## 🔧 Installation

### Swift Package Manager (Recommended)

To integrate **KHBannerView** into your Xcode project using SPM:

1. Open your project in Xcode.
2. Go to **File > Add Packages...**
3. Enter the following repository URL in the search bar:
`https://github.com/kyeonghunkim0/KHBannerView.git`
4. Select the version (e.g., `Up to Next Major` with `1.0.0`).

Or, add it to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "[https://github.com/kyeonghunkim0/KHBannerView.git](https://github.com/kyeonghunkim0/KHBannerView.git)", from: "1.0.0")
]

```

### CocoaPods

To integrate **KHBannerView** using CocoaPods, specify it in your `Podfile`:

```ruby
platform :ios, '13.0'
use_frameworks!

target 'YourAppTarget' do
  pod 'KHBannerView'
end

```

## 📄 License

All source code is licensed under the [MIT License]([https://github.com/kyeonghunkim0/KHBannerView/blob/master/LICENSE]).


