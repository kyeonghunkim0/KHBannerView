//
//  KHBannerCollectionView.swift
//  KHBannerView
//
//  Created by 김경훈 on 12/15/24.
//

import UIKit

public class KHBannerCollectionView: UICollectionView{
    
    var bannerItems: [KHBannerItem]?
    var bannerTimer: Timer?
    var timeInterval: TimeInterval = 3.0
    var selectCompletionHandler: (() -> Void)?
    
    public override func layoutSubviews() {
//        self.register(KHBannerViewCell.self, forCellWithReuseIdentifier: KHBannerViewCell.identifier)
//        self.dataSource = self
//        self.delegate = self
    }
//    
//    public override func cellForItem(at indexPath: IndexPath) -> UICollectionViewCell? {
//        guard let cell = self.dequeueReusableCell(withReuseIdentifier: KHBannerViewCell.identifier,
//                                                  for: indexPath) as? KHBannerViewCell else { return nil }
//        return cell
//    }
}

//extension KHBannerCollectionView: UICollectionViewDataSource, UICollectionViewDelegate{
//    //MARK: UICollectionViewDelegateFlowLayout
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return collectionView.bounds.size
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
//    //MARK: UICollectionViewDataSource, UICollectionViewDelegate
//    /// Index of items currentl visubale in KHBannerView
//    private func visibleItemCellIndex() -> Int{
//        return self.indexPathsForVisibleItems[0].item
//    }
//    
//    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return bannerItems.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        print(#function)
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KHBannerViewCell.identifier,
//                                                            for: indexPath) as? KHBannerViewCell,
//              let bannerItems = self.bannerItems
//        else { fatalError(#function) }
//        cell.configure(bannerItems[indexPath.row])
//        return cell
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        self.selectHandler?()
//    }
//    
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        if let width = bannerCollectionView?.frame.width,
//            let count = self.bannerItems?.count{
//            if scrollView.contentOffset.x == width * CGFloat(count + 1) {
//                scrollView.setContentOffset(.init(x: UIScreen.main.bounds.width,
//                                                  y: scrollView.contentOffset.y),
//                                            animated: false)
//            }
//        }
//    }
//}
