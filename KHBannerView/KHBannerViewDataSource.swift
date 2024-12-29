//
//  KHBannerViewDataSource.swift
//  KHBannerView
//
//  Created by 김경훈 on 12/18/24.
//

import UIKit

class KHBannerViewDataSource: NSObject{
    
    private weak var bannerView: KHBannerView!
    private var bannerItems: [KHBannerItem]?
    private var totalBannerCount: Int {
        if let bannerItems = self.bannerItems {
            return bannerItems.count
        }
        return 0
    }
    private var currentPage: Int = 0 {
        didSet {
            if let bannerItem = bannerItems?[currentPage]{
                delegate?.banner?(bannerView: bannerView,
                                  didSelect: bannerItem,
                                  with: 0)
            }
        }
    }
    
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.clipsToBounds = true
        collectionView.contentInset = .zero
        collectionView.register(KHBannerViewCell.self, forCellWithReuseIdentifier: KHBannerViewCell.identifier)
        return collectionView
    }()
    
    private var bannerTimer: Timer?
    private var timeInterval: TimeInterval = 3
    var selectHandler: (() -> Void)?
    var delegate: KHBannerViewDelegate?
    
    init(bannerView: KHBannerView!,
         delegate: KHBannerViewDelegate? = nil,
         bannerItems: [KHBannerItem],
         timeInterval: TimeInterval,
         selectHandler: (() -> Void)? = nil) {
        super.init()
        
        self.bannerView = bannerView
        self.timeInterval = timeInterval
        self.delegate = delegate
        self.currentPage = 0
        self.selectHandler = selectHandler
        bannerView.delegate = self.delegate
        

        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        bannerView.addSubview(collectionView)
        
        addContsraintsToPageControl()
        
        self.bannerItems = bannerItems
        
        if(bannerItems.count > 1){
            if let first = bannerItems.first,
               let last = bannerItems.last{
                self.bannerItems?.append(first)
                self.bannerItems?.insert(last, at: 0)
                collectionView.setContentOffset(.init(x: bannerView.frame.width, y: collectionView.contentOffset.y), animated: false)
            }
        }
        collectionView.reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addContsraintsToPageControl() {
        // KHBannerCollectionView
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: bannerView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: bannerView.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bannerView.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: bannerView.trailingAnchor)
        ])
    }
    /// Active KHBanner Scroll Timer
    func activateBannerTimer(){
        print(#function)
        bannerTimer?.invalidate()
        bannerTimer = Timer.scheduledTimer(timeInterval: timeInterval,
                                           target: self,
                                           selector: #selector(timerCallBack),
                                           userInfo: nil,
                                           repeats: true)
    }
    
    @objc private func timerCallBack(){
        guard let count = self.bannerItems?.count,
            (bannerItems?.count ?? 0) > 1 else { return }
        let nextItem = self.visibleItemCellIndex() + 1
        let nextIndexPath = IndexPath(item: nextItem, section: 0)
        if nextIndexPath.item >= 0 && nextIndexPath.item < count {
            collectionView.scrollToItem(
                at: nextIndexPath,
                at: .centeredHorizontally,
                animated: true)
            self.currentPage = (nextItem) % (count - 2)
        }
        else if(nextIndexPath.item == count){
            collectionView.scrollToItem(
                at: IndexPath(item: 1, section: 0),
                at: .centeredHorizontally,
                animated: false)
            self.currentPage = (self.visibleItemCellIndex()) % (count - 2)
        }
    }
    
    func invalideBannerTimer(){
        bannerTimer?.invalidate()
    }
}

extension KHBannerViewDataSource: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let size = CGSize(width: MainScreenWidth, height: 200)
        let size = CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    //MARK: UICollectionViewDataSource, UICollectionViewDelegate
    /// Index of items currentl visubale in KHBannerView
    private func visibleItemCellIndex() -> Int{
        return collectionView.indexPathsForVisibleItems[0].item
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bannerItems!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KHBannerViewCell.identifier,
                                                            for: indexPath) as? KHBannerViewCell,
              let bannerItems = self.bannerItems
        else { fatalError(#function) }
        cell.configure(bannerItems[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let currentItem = self.bannerItems?[indexPath.item]{
            delegate?.banner?(bannerView: self.bannerView, didSelect: currentItem, with: indexPath.item)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = bannerView.frame.width
        if let bannerItems = self.bannerItems?.count{
            let count = bannerItems - 2
//                //마지막 배너가 보이면 1번째 index의 배너로 이동
//            if scrollView.contentOffset.x == width * CGFloat(count + 1) {
//                scrollView.setContentOffset(.init(x: width, y: scrollView.contentOffset.y),
//                                            animated: false)
//            }
//            self.bannerPageControl.currentPage = Int((scrollView.contentOffset.x / MainScreenWidth)) % bannerCount
              
            if scrollView.contentOffset.x == 0 {
                scrollView.setContentOffset(.init(x: width * Double(count-2), y: scrollView.contentOffset.y), animated: false)
            }
            if scrollView.contentOffset.x == Double(count-1) * width {
                scrollView.setContentOffset(.init(x: width, y: scrollView.contentOffset.y), animated: false)
            }
        }
    }
}
