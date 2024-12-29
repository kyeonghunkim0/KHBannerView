//
//  KHBannerView.swift
//  KHBannerView
//
//  Created by 김경훈 on 12/15/24.
//

import UIKit

public class KHBannerView: UIView, KHBannerViewDelegate{
    
    public var collectionView: KHBannerCollectionView!
    public weak var delegate: KHBannerViewDelegate?{
        didSet {
            collectionView.bannerDelegate = delegate
        }
    }
    
    private var _timeInterval: TimeInterval = 3.0
    /// The KHBannerView's banner timer seconds.
    /// - The default value is `3.0`.
    public var timeInterval: TimeInterval {
        get {
            return _timeInterval
        }
        set {
            _timeInterval = newValue
        }
    }
    // MARK: - Initialize
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // Add Constraints
    private func addContsraints() {
        guard let superview = collectionView.superview else {
             assertionFailure("collectionView has no superview")
             return
         }
        
         NSLayoutConstraint.activate([
             collectionView.topAnchor.constraint(equalTo: superview.topAnchor),
             collectionView.leadingAnchor.constraint(equalTo: superview.leadingAnchor),
             collectionView.bottomAnchor.constraint(equalTo: superview.bottomAnchor),
             collectionView.trailingAnchor.constraint(equalTo: superview.trailingAnchor)
         ])
    }
    // MARK: - Configuration
    /// Configure KHBannerView
    public func configure(banners: [KHBannerItem]){
        collectionView = KHBannerCollectionView(bannerView: self,
                                                bannerItems: banners)
        
        collectionView.timeInterval = _timeInterval
        startBanner()
    }
    ///
    public func startBanner(){
        collectionView.activateBannerTimer()
    }
    
    public func stopBanner(){
        collectionView.invalideBannerTimer()
    }
}

