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
    
    var onDeleteButtonTapped: (() -> Void)?
    var onCopyLinkButtonTapped: (() -> Void)?
    var onSettingButtonTapped: (() -> Void)?

    private lazy var tripNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16.0, weight: .regular)
        label.text = "여행 이름"
        label.textColor = UIColor(named: "grayA")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var tripDateLabel: UILabel = {
        let label = UILabel()
        label.text = "0000. 00. 00 ~ 9999. 99. 99"
        label.textColor = UIColor(named: "grayA")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var companionIcon: UIImageView =  {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "companion")
        imgView.isHidden = true
        imgView.tintColor = UIColor(named: "grayB")
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.snp.makeConstraints({ make in
            make.width.height.equalTo(18.0)
        })
        return imgView
    }()
    
    private lazy var settingBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named:"ellipsis_vertical"), for: .normal)
        btn.tintColor = UIColor(named: "grayB")
        btn.snp.makeConstraints({ make in
            make.width.height.equalTo(24.0)
        })
//        btn.addTarget(self, action: #selector(settingBtnTapped), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.showsMenuAsPrimaryAction = true
        return btn
    }()
    
//    @objc func settingBtnTapped(){
//        onSettingButtonTapped?()
//    }
    
    private func setup() {
        self.contentView.backgroundColor = UIColor(named: "grayC")
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
        
        settingBtn.menu =  UIMenu(title: "", children: [
            UIAction(title: "여행 삭제", image: nil, handler: { _ in
                print("Action 1 tapped")
                self.onDeleteButtonTapped?()
            }),
            UIAction(title: "여행 초대 링크 복사", image: nil, handler: { _ in
                print("Action 2 tapped")
                self.onCopyLinkButtonTapped?()
            }),
            UIAction(title: "편집", image: nil, handler: { _ in
                print("Action 2 tapped")
                self.onSettingButtonTapped?()
            })
        ])
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
