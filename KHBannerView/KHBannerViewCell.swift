//
//  KHBannerViewCell.swift
//  KHBannerView
//
//  Created by 김경훈 on 12/15/24.
//

import UIKit

class KHBannerViewCell: UICollectionViewCell {
    
    static let identifier: String = "KHBannerViewCell"
    
    private let bannerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: - Initialize
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    // MARK: - Set up View
    private func setupViews() {
        contentView.addSubview(bannerImageView)
        
        NSLayoutConstraint.activate([
            bannerImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            bannerImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bannerImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            bannerImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    // MARK: - Configuration
    func configure(_ banner: KHBannerItem, mode: UIView.ContentMode? = nil) {
        bannerImageView.image = banner.image
    }
}
