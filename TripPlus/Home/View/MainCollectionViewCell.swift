//
//  MainCollectionViewCell.swift
//  TripPlus
//
//  Created by 유대상 on 12/9/24.
//

import Foundation
import UIKit
import SnapKit

class MainCollectionViewCell : UICollectionViewCell{
    static let identifier = "MainCollectionViewCell"
    
    private lazy var thumbnailImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "PRETENDARD-Semibold", size: 34)
        label.textColor = UIColor(named: "grayD")
        label.numberOfLines = 0
        label.text = "Title"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "PRETENDARD-Light", size: 12)
        label.textColor = UIColor(named: "grayD")
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        label.text = "description"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var writtenByLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "PRETENDARD-Light", size: 12)
        label.textColor = UIColor(named: "grayD")
        label.text = "writtenBy"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Lifecycle
     override init(frame: CGRect) {
         super.init(frame: frame)
         setupUI()
     }
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
    
    private func setupUI() {
        [thumbnailImageView, titleLabel, descriptionLabel, writtenByLabel].forEach({
            self.addSubview($0)
        })
        
        thumbnailImageView.snp.makeConstraints({make in
            make.top.bottom.leading.trailing.equalToSuperview()
        })
        
        writtenByLabel.snp.makeConstraints({ make in
            make.bottom.equalToSuperview().offset(-54)
            make.leading.equalToSuperview().offset(15)
        })

        descriptionLabel.snp.makeConstraints({ make in
            make.bottom.equalTo(writtenByLabel.snp.top).offset(10)
            make.leading.equalToSuperview().offset(15)
        })
        
        titleLabel.snp.makeConstraints({ make in
            make.bottom.equalTo(descriptionLabel.snp.top).offset(10)
            make.leading.equalToSuperview().offset(15)
        })
    }
    
    //CollectionView에서 사용
    func configure(title: String, description: String, writtenBy: String) {
        titleLabel.text = title
        descriptionLabel.text = description
        writtenByLabel.text = writtenBy
    }
     
     override func prepareForReuse() {
         super.prepareForReuse()
         titleLabel.text = nil
         descriptionLabel.text = nil
         writtenByLabel.text = nil
     }
}
