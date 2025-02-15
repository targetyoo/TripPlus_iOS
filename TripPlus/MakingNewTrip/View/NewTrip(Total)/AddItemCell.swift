//
//  AddItemCell.swift
//  TripPlus
//
//  Created by 유대상 on 1/19/25.
//

import Foundation
import UIKit
import SnapKit

class AddItemCell: UICollectionViewCell{
    static let identifier = "AddItemCell"

    lazy var addBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "cellPlus"), for: .normal)
        btn.tintColor = UIColor(named: "grayB")
        btn.snp.makeConstraints({make in
            make.width.height.equalTo(24.0)
        })
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
    }
    
    private func setViews(){
        self.addSubview(addBtn)
        
        addBtn.snp.makeConstraints({ make in
            make.leading.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
        })
    }
    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

