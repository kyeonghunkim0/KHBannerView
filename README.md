# KHBannerView

[![Version](https://img.shields.io/cocoapods/v/KHBannerView.svg?style=flat)](https://cocoapods.org/pods/KHBannerView)
[![License](https://img.shields.io/cocoapods/l/KHBannerView.svg?style=flat)](https://cocoapods.org/pods/KHBannerView)
[![Platform](https://img.shields.io/cocoapods/p/KHBannerView.svg?style=flat)](https://cocoapods.org/pods/KHBannerView)

**KHBannerView** is A simple infinity carousel that automatically scrolls banners.

---

## 📖 How To Use
* Swift
```swift
import KHBannerView

// Set banner Items
let bannerItem: [KHBannerItem] = [
            KHBannerItem(image: UIImage(named: "A")),
            KHBannerItem(image: UIImage(named: "B")),
            KHBannerItem(image: UIImage(named: "C"))
]
// configure KHBannerView
bannerView.configure(banners: bannerItem)
// Delegate KHBannerView
bannerView.delegate = self
// Set KHBanner Timer's timeinterval      
bannerView.timeInterval = 4.0

// KHBannerViewDelegate
func banner(bannerView: KHBannerView, didSelect: KHBannerItem, with index: Int) {
}

func banner(bannerView: KHBannerView, didScrollTo: KHBannerItem, with index: Int) {
}
```

## 🔧 Installation

[CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To integrate Alamofire into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
pod 'KHBannerView'
```

## Licenses

All source code is licensed under the [MIT License]([https://github.com/kyeonghunkim0/KHBannerView/blob/master/LICENSE]).


