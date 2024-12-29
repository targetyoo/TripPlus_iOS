//
//  ListCollectionViewCell.swift
//  TripPlus
//
//  Created by 유대상 on 12/9/24.
//

import Foundation
import UIKit
import SnapKit

class ListCollectionViewCell: UICollectionViewCell{
    static let identifier = "ListCollectionViewCell"

       private lazy var cellNum : UILabel = {
           let label = UILabel()
           label.textColor = UIColor(named: "grayA")
           label.font = UIFont(name: "PRETENDARD-Medium", size: 20)
           label.text = "\(1)"
           label.numberOfLines = 1
           label.translatesAutoresizingMaskIntoConstraints = false
           return label
       }()
       
       private lazy var cellTitle : UILabel = {
           let label = UILabel()
           label.textColor = UIColor(named: "grayA")
           label.font = UIFont(name: "PRETENDARD-Regular", size: 16)
           label.text = "좋았던 여행"
           label.numberOfLines = 1
           label.translatesAutoresizingMaskIntoConstraints = false
           return label
       }()
       
       private lazy var cellLocation : UILabel = {
           let label = UILabel()
           label.textColor = UIColor(named: "grayB")
           label.font = UIFont(name: "PRETENDARD-Light", size: 12)
           label.text = "경상도"
           label.numberOfLines = 1
           label.translatesAutoresizingMaskIntoConstraints = false
           return label
       }()

       private lazy var cellBody : UILabel = {
           let label = UILabel()
           label.textColor = UIColor(named: "grayA")
           label.font = UIFont(name: "PRETENDARD-Light", size: 12)
           label.text = "여행을 어디로갈까아 여행을 어디로갈까아 여행을 어디로갈까아 여행을 어디로갈까아 여행을 어디로갈까아 여행을 어디로갈까아 여행을 어디로갈까아 여행을 어디로갈까아 여행을 어디로갈까아 여행을 어디로갈까아 여행을 어디로갈까아 여행을 어디로갈까아"
           label.numberOfLines = 3
           label.lineBreakMode = .byTruncatingTail
           label.setLineSpacing(lineSpacing: label.font.lineHeight)
           label.translatesAutoresizingMaskIntoConstraints = false
           return label
       }()
       
       private lazy var verticalStackView: UIStackView = {
           let stackView = UIStackView(arrangedSubviews: [cellTitle, cellLocation, cellBody])
           stackView.axis = .vertical
           stackView.spacing = 10 //이거임!!!
           stackView.translatesAutoresizingMaskIntoConstraints = false
           return stackView
       }()
       
       
       private lazy var cellThumbnailImage : UIImageView = {
           let imageView = UIImageView()
           imageView.backgroundColor = .lightGray
           imageView.contentMode = .scaleAspectFill
           imageView.clipsToBounds = true
           imageView.layer.cornerRadius = 7
           imageView.translatesAutoresizingMaskIntoConstraints = false
           return imageView
       }()
       
       private lazy var cellThumbnailNum : UILabel = {
           let label = UILabel()
           label.textColor = UIColor(named: "grayA")
           label.font = UIFont(name: "PRETENDARD-Light", size: 12)
           label.text = "+00"
           label.numberOfLines = 0
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
        //ListCollectionViewCell,  cell height : 155
        [cellNum, verticalStackView, cellThumbnailImage].forEach({
            self.addSubview($0)
        })
        
        cellThumbnailImage.addSubview(cellThumbnailNum)
        
        cellNum.snp.makeConstraints({ make in
            make.top.equalTo(verticalStackView.snp.top)
            make.leading.equalToSuperview().offset(15.0)
            make.width.equalTo(35.0)
        })
        
        verticalStackView.snp.makeConstraints({ make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(cellNum.snp.trailing).offset(20.0)
            make.trailing.equalTo(cellThumbnailImage.snp.leading).offset(-20.0)
        })
        
        cellThumbnailImage.snp.makeConstraints({ make in
            make.top.equalTo(verticalStackView.snp.top)
            make.trailing.equalToSuperview().offset(-15.0)
            make.width.height.equalTo(97.0)
        })
        
        cellThumbnailNum.snp.makeConstraints({ make in
            make.trailing.bottom.equalToSuperview().offset(-10.0)
        })
    }
    
    //CollectionView에서 사용
    func configure(index: Int, title: String, location: String, body: String, thumbnailImage: UIImage, picCount: String) {
        cellNum.text = "\(index)"
        cellTitle.text = title
        cellLocation.text = location
        cellBody.text = body
//        cellThumbnailImage.image = thumbnailImage
        cellThumbnailNum.text = picCount
    }
     
     override func prepareForReuse() {
         super.prepareForReuse()
         cellNum.text = nil
         cellTitle.text = nil
         cellLocation.text = nil
         cellBody.text = nil
         cellThumbnailImage.image = nil
         cellThumbnailNum.text = nil
     }
}
