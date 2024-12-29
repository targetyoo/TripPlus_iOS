//
//  RankingCell.swift
//  TripPlus
//
//  Created by 유대상 on 12/18/24.
//

import Foundation
import UIKit
import SnapKit

class RankingCell : UICollectionViewCell {
    static let identifier = "RankingCell"
    
    
    private lazy var cellIndexLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "grayA")
        label.font = UIFont(name: "PRETENDARD-Medium", size: 20.0)
        label.text = "0"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var cellNationalFlag: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "nationalFlag") //API를 통해 변경될 예정
        imgView.backgroundColor = .darkGray
        imgView.layer.masksToBounds = true
        imgView.snp.makeConstraints({ make in
            make.width.height.equalTo(44.0)
        })
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    private lazy var cellNationCityLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "grayA")
        label.font = UIFont(name: "PRETENDARD-Medium", size: 20.0)
        label.text = "대한민국 서울"
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
    
    func setViews(){
        [cellIndexLabel, cellNationalFlag, cellNationCityLabel].forEach({self.addSubview($0)})
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        cellIndexLabel.snp.makeConstraints({ make in
            make.leading.equalToSuperview().offset(15.0)
            make.centerY.equalToSuperview()
        })
        
        cellNationalFlag.snp.makeConstraints({ make in
            make.leading.equalTo(cellIndexLabel.snp.trailing).offset(15.0)
            make.centerY.equalToSuperview()
        })
        
        cellNationCityLabel.snp.makeConstraints({ make in
            make.leading.equalTo(cellNationalFlag.snp.trailing).offset(15.0)
            make.centerY.equalToSuperview()
        })
    }
    
    
    //CollectionView에서 사용
    func configure(index: Int, imgURL: String, NationCity: String) {
        layoutIfNeeded()
        cellNationalFlag.layer.cornerRadius = cellNationalFlag.frame.width / 2

        cellIndexLabel.text = "\(index)"
        //        cellNationalFlag.image = URL
        cellNationCityLabel.text = NationCity
    }

    
    override func prepareForReuse(){
        super.prepareForReuse()
        cellIndexLabel.text = nil
        cellNationalFlag.image = nil
        cellNationCityLabel.text = nil
    }
    
}
