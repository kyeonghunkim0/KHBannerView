//
//  KHBannerCollectionView.swift
//  KHBannerView
//
//  Created by 김경훈 on 12/15/24.
//

import UIKit

public class KHBannerCollectionView: UICollectionView{
    
    private var bannerView: KHBannerView!
    private var bannerItems: [KHBannerItem]?
    
    private var bannerTimer: Timer?
    var timeInterval: TimeInterval = 3
    
    weak var bannerDelegate: KHBannerViewDelegate?
    
    /// inintialize KHBannerCollectionView
    init(bannerView: KHBannerView,
         bannerItems: [KHBannerItem]){
        // configure UICollectionViewFlowLayout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        // initialize and configure UICollectionView
        super.init(frame: .zero, collectionViewLayout: layout)
        self.configureCollectionview()
        self.bannerView = bannerView
        // Add Constraints
        self.addContsraints()
        // Set up BannerItems
        self.bannerItems = bannerItems
        if(bannerItems.count > 1){
            if let first = bannerItems.first,
               let last = bannerItems.last{
                self.bannerItems?.append(first)         // First component append array.
                self.bannerItems?.insert(last, at: 0)   // Last componet insert array.
                self.setContentOffset(.init(x: bannerView.frame.width, y: self.contentOffset.y),
                                      animated: false)
            }
        }
        self.reloadData()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /// Configure UICollectionView
    private func configureCollectionview(){
        self.isPagingEnabled = true
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
        self.clipsToBounds = true
        self.contentInset = .zero
        self.delegate = self
        self.dataSource = self
        self.translatesAutoresizingMaskIntoConstraints = false
        self.register(KHBannerViewCell.self, forCellWithReuseIdentifier: KHBannerViewCell.identifier)
    }
    /// Add Constraints
    private func addContsraints() {
        bannerView.addSubview(self)
        
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: bannerView.topAnchor),
            self.leadingAnchor.constraint(equalTo: bannerView.leadingAnchor),
            self.bottomAnchor.constraint(equalTo: bannerView.bottomAnchor),
            self.trailingAnchor.constraint(equalTo: bannerView.trailingAnchor)
        ])
    }
    /// Index of items currentl visubale in KHBannerView
    private func visibleItemCellIndex() -> Int{
        return self.indexPathsForVisibleItems[0].item
    }
    /// Active KHBanner Scroll Timer
    func activateBannerTimer(){
        bannerTimer?.invalidate()
        bannerTimer = Timer.scheduledTimer(timeInterval: timeInterval,
                                           target: self,
                                           selector: #selector(timerCallBack),
                                           userInfo: nil,
                                           repeats: true)
    }
    /// KHBanner Timer CallBack function
    @objc private func timerCallBack(){
        guard let count = self.bannerItems?.count,
              (bannerItems?.count ?? 0) > 1 else { return }
        let nextItem = self.visibleItemCellIndex() + 1
        let nextIndexPath = IndexPath(item: nextItem, section: 0)
        if nextIndexPath.item >= 0 && nextIndexPath.item < count {
            self.scrollToItem(
                at: nextIndexPath,
                at: .centeredHorizontally,
                animated: true)
        }
        else if(nextIndexPath.item == count){
            self.scrollToItem(
                at: IndexPath(item: 1, section: 0),
                at: .centeredHorizontally,
                animated: false)
        }
    }
    /// Invalide KHBanner timer
    func invalideBannerTimer(){
        bannerTimer?.invalidate()
    }
}
extension KHBannerCollectionView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
        return size
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    //MARK: UICollectionViewDataSource, UICollectionViewDelegate
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bannerItems!.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KHBannerViewCell.identifier,
                                                            for: indexPath) as? KHBannerViewCell,
              let bannerItems = self.bannerItems
        else { fatalError(#function) }
        cell.configure(bannerItems[indexPath.row])
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let banner = bannerItems?[indexPath.row] else { return }
        self.bannerDelegate?.banner?(bannerView: bannerView, didScrollTo: banner, with: indexPath.item)
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = self.frame.width
        // delegate
        var index = Int(scrollView.contentOffset.x / scrollView.frame.width)
        if let bannerItems = bannerItems, let bannerItemsCount = self.bannerItems?.count{
            let count = bannerItemsCount - 2
            // if last banner is coming, banner will move to first index of banners
            if scrollView.contentOffset.x == width * CGFloat(count + 1) {
                scrollView.setContentOffset(.init(x: width, y: scrollView.contentOffset.y),
                                            animated: false)
                index = index % count
            }
            bannerDelegate?.banner?(bannerView: bannerView,
                                    didScrollTo: bannerItems[index],
                                    with: index)
        }
    }
}
