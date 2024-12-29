//
//  KHBannerViewDelegate.swift
//  KHBannerView
//
//  Created by 김경훈 on 12/18/24.
//

import UIKit

/// KHBannerViewDelegate.
@objc public protocol KHBannerViewDelegate{
    /// Tells the delegate when the user scrolls the banner view within the `KHBannerView`.
    @objc optional func banner(bannerView: KHBannerView,
                               didScrollTo: KHBannerItem,
                               with index: Int)
    /// Tells the delegate that the `Banner` at the specified index path was selected.
    @objc optional func banner(bannerView: KHBannerView,
                               didSelect: KHBannerItem,
                               with index: Int)
    /// Asks your data source object for the cell that corresponds to the specified item in the KHBanner's collection view.
    @objc optional func banner(collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
}
