//
//  MyTripListCollectionViewCell.swift
//  TripPlus
//
//  Created by 유대상 on 5/31/25.
//

import Foundation
import UIKit
import SnapKit

class MyTripListCollectionViewCell: UICollectionViewCell {
    static let identifier = "MyTripListCollectionViewCell"
    
    private lazy var tripNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16.0, weight: .regular)
        label.text = "여행 이름"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var tripDateLabel: UILabel = {
        let label = UILabel()
        label.text = "0000. 00. 00 ~ 9999. 99. 99"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var companionIcon: UIImageView =  {
        let image = UIImageView()
        image.image = UIImage(systemName: "person.2.fill")
        image.isHidden = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.snp.makeConstraints({ make in
            make.width.height.equalTo(18.0)
        })
        return image
    }()
    
    private lazy var settingBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        btn.snp.makeConstraints({ make in
            make.width.height.equalTo(24.0)
        })
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private func setup() {
        self.contentView.backgroundColor = .lightGray
        self.contentView.layer.cornerRadius = 14.0
        
        [tripNameLabel, tripDateLabel, companionIcon, settingBtn].forEach{ contentView.addSubview($0) }
        
        tripNameLabel.snp.makeConstraints({ make in
            make.top.equalToSuperview().offset(20.0)
            make.leading.equalToSuperview().offset(20.0)
        })
        
        tripDateLabel.snp.makeConstraints({ make in
            make.top.equalTo(tripNameLabel.snp.bottom).offset(20.0)
            make.leading.equalToSuperview().offset(20.0)
        })
        
//        companionIcon.snp.makeConstraints({ make in
//            make.trailing.equalToSuperview().offset(-10.0)
//            make.bottom.equalToSuperview().offset(-10.0)
//        })
        
        settingBtn.snp.makeConstraints({ make in
            make.top.equalToSuperview().offset(20.0)
            make.trailing.equalToSuperview().offset(-20.0)
        })
    }
    
    
    func configure(tripName: String, tripDate: String, isCompanion: Bool) {
        tripNameLabel.text = tripName
        tripDateLabel.text = tripDate
        if isCompanion {
            companionIcon.isHidden = false
        }else{
            companionIcon.isHidden = true
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        // 셀 재사용 시 초기화
        companionIcon.isHidden = true
    }
    
}
