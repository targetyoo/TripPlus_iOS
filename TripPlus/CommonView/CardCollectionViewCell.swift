//
//  CardCollectionViewCell.swift
//  TripPlus
//
//  Created by 유대상 on 12/9/24.
//

import Foundation
import UIKit
import SnapKit

class CardCollectionViewCell: UICollectionViewCell{
    static let identifier = "CardCollectionViewCell"

    private lazy var cellThumbnailImage : UIImageView = {
           let imageView = UIImageView()
           imageView.backgroundColor = .lightGray
           imageView.contentMode = .scaleAspectFill
           imageView.clipsToBounds = true
           imageView.layer.cornerRadius = DesignSystem.CardCollection.thumbnail_cornerRadius
           imageView.translatesAutoresizingMaskIntoConstraints = false
           return imageView
       }()
       
       private lazy var cellThumbnailName : UILabel = {
           let label = UILabel()
           label.textColor = DesignSystem.CardCollection.thumbnail_name_textColor
           label.font = DesignSystem.CardCollection.thumbnail_name_font
           label.text = "My Location"
           label.textAlignment = .left
           label.numberOfLines = 0
           label.setLineSpacing(lineHeight: label.font.lineHeight)
           label.translatesAutoresizingMaskIntoConstraints = false
           return label
       }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setViews() {
//        [cellThumbnailImage, cellThumbnailName].forEach({
//            self.addSubview($0)
//        })
        
        self.addSubview(cellThumbnailImage)
        cellThumbnailImage.addSubview(cellThumbnailName)
        
        cellThumbnailImage.snp.makeConstraints({ make in
            make.edges.equalToSuperview()
        })
        
        cellThumbnailName.snp.makeConstraints({ make in
            make.leading.equalToSuperview().offset(DesignSystem.CardCollection.thumbnail_name_leading)
            make.bottom.equalToSuperview().offset(DesignSystem.CardCollection.thumbnail_name_trailing)
        })
    }
    
    //CollectionView에서 사용
    func configure(thumbnail: String, thumbnailName: String) {
//        cellThumbnailImage.image = thumbnail
        cellThumbnailName.text = thumbnailName
    }
     
     override func prepareForReuse() {
         super.prepareForReuse()
         cellThumbnailImage.image = nil
         cellThumbnailName.text = nil
     }
}
