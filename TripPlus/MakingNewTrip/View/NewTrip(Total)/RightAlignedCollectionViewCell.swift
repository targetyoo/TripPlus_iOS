//
//  RightAlignedCollectionViewCell.swift
//  TripPlus
//
//  Created by 유대상 on 1/19/25.
//

import Foundation
import UIKit
import SnapKit

class RightAlignedCollectionViewCell: UICollectionViewCell{
    static let identifier = "RightAlignedCollectionViewCell"

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "PRETENDARD-Regular", size: 16.0)
        label.textColor = UIColor(named: "grayA")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var deleteBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "x"), for: .normal)
        btn.setTitleColor(UIColor(named: "grayB"), for: .normal)
        btn.tintColor = UIColor(named: "grayB")
        btn.snp.makeConstraints({make in
            make.width.height.equalTo(DesignSystem.Common.icon_size)
        })
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
    }
    
    
    private func setViews(){
        
        [titleLabel, deleteBtn].forEach({self.addSubview($0)})
        
        titleLabel.snp.makeConstraints({ make in
            make.leading.equalToSuperview().offset(10.0)
            make.centerY.equalToSuperview()
        })
        
        deleteBtn.snp.makeConstraints({ make in
            make.leading.equalTo(titleLabel.snp.trailing)
            make.trailing.equalToSuperview().offset(-5.0)
            make.centerY.equalToSuperview()
        })
  
        self.layer.cornerRadius = RIGHTALIGHNEDCELL_ITEM_RADIUS
        self.layer.masksToBounds = true
        self.backgroundColor = UIColor(named: "tripGreen")?.withAlphaComponent(0.25)
    }
  
    func configure(title: String){
        titleLabel.text = title
    }
    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
