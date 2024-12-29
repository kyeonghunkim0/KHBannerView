//
//  KHBannerView.swift
//  KHBannerView
//
//  Created by 김경훈 on 12/15/24.
//

import UIKit

public class KHBannerView: UIView{
    
    public var collectionView: KHBannerCollectionView!
    public var pageControl: KHBannerPageControl!
    public var delegate: KHBannerViewDelegate?
    private var dataSource: KHBannerViewDataSource!
    
    public var currentPage: Int{
        return pageControl.currentPage
    }
    
    /// The KHBannerView’s background color.
    /// . The default value is white.
    public override var backgroundColor: UIColor?{
        get{
            return UIColor.white
        }
        set{
            self.backgroundColor = newValue
        }
    }
    /// The KHBannerPage’s background color.
    /// . The default value is lightGray.
    private var _pageControlBackgroundColor: UIColor? = UIColor.lightGray
    public var pageControlBackgroundColor: UIColor? {
        get {
            return _pageControlBackgroundColor
        }
        set {
            _pageControlBackgroundColor = newValue
        }
    }
    /// The KHBannerPage’s background color.
    /// . The default value is darkGray.
    private var _pageControlSelectedBackgroundColor: UIColor? = UIColor.darkGray
    public var pageControlSelectedBackgroundColor: UIColor? {
        get{
            return _pageControlSelectedBackgroundColor
        }
        set{
            _pageControlSelectedBackgroundColor = newValue
        }
    }
    // MARK: - Initialize
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialize(){
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//        collectionView = KHBannerCollectionView(frame: bounds,
//                                                collectionViewLayout: layout)
//        collectionView.isPagingEnabled = true
//        collectionView.showsHorizontalScrollIndicator = false
//        collectionView.showsVerticalScrollIndicator = false
//        collectionView.backgroundColor = self.backgroundColor
//        collectionView.clipsToBounds = true
//        
//        
//        pageControl = KHBannerPageControl()
//        pageControl.backgroundColor = pageControlBackgroundColor
//        pageControl.pageIndicatorTintColor = pageControlSelectedBackgroundColor
//        
//        [collectionView].forEach{
//            $0.translatesAutoresizingMaskIntoConstraints = false
//            addSubview($0)
//        }
//        
//        addContsraintsToPageControl()
    }
    
    private func addContsraintsToPageControl() {
        // KHBannerCollectionView
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
        // PageControl
//        addConstraint(
//            NSLayoutConstraint(
//                item: pageControl!,
//                attribute: .width,
//                relatedBy: .equal,
//                toItem: self,
//                attribute: .width,
//                multiplier: CGFloat(2) / 3,
//                constant: 0
//            )
//        )
//        addConstraint(
//            NSLayoutConstraint(
//                item: pageControl!,
//                attribute: .height,
//                relatedBy: .equal,
//                toItem: nil,
//                attribute: .notAnAttribute,
//                multiplier: 1,
//                constant: 1
//            )
//        )
//        addConstraint(
//            NSLayoutConstraint(
//                item: pageControl!,
//                attribute: .top,
//                relatedBy: .equal,
//                toItem: self,
//                attribute: .top,
//                multiplier: 1,
//                constant: 0
//            )
//        )
//        addConstraint(
//            NSLayoutConstraint(
//                item: pageControl!,
//                attribute: .centerX,
//                relatedBy: .equal,
//                toItem: self,
//                attribute: .centerX,
//                multiplier: 1,
//                constant: 0
//            )
//        )
    }
    
    /// Configure KHBannerView  -
    public func configure(banners: [KHBannerItem],
                          delegate: KHBannerViewDelegate?,
                          timeInterval: Double,
                          selectHandler: (() -> Void)?){
        
        dataSource = KHBannerViewDataSource(bannerView: self,
                                            bannerItems: banners, timeInterval: timeInterval,
                                            selectHandler: selectHandler)
        print(#file, #function, "BannerItem Count ===> \(banners.count)")
        
        dataSource.collectionView.delegate = self.dataSource
        dataSource.collectionView.dataSource = self.dataSource
        
        startBanner()
    }
    
    public func startBanner(){
        dataSource.activateBannerTimer()
    }
    
    public func stopBanner(){
        dataSource.invalideBannerTimer()
    }
}

