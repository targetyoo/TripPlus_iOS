//
//  CategoryCollectionViewCell.swift
//  TripPlus
//
//  Created by 유대상 on 1/18/25.
//

import Foundation
import UIKit
import SnapKit

class CategoryCollectionViewCell: UICollectionViewCell{
    static let identifier = "CategoryCollectionViewCell"
    
    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "PRETENDARD-Regular", size: 16.0)
        label.textColor = UIColor(named: "grayA")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var selectBtn: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "checkCircle"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var cellBoarder: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "grayB")
        view.snp.makeConstraints({ make in
            make.height.equalTo(1.0)
        })
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
    }
    
    private func setViews() {
        [categoryLabel, selectBtn, cellBoarder].forEach({self.addSubview($0)})
        
        categoryLabel.snp.makeConstraints({ make in
            make.leading.equalToSuperview().offset(15.0)
            make.centerY.equalToSuperview()
        })
        
        selectBtn.snp.makeConstraints({ make in
            make.trailing.equalToSuperview().offset(-15.0)
            make.centerY.equalToSuperview()
        })
        
        cellBoarder.snp.makeConstraints({ make in
            make.top.equalTo(self.snp.bottom)
            make.leading.trailing.equalToSuperview()
        })
    }
    
    func configure(category: String) {
        categoryLabel.text = category
    }
     
     override func prepareForReuse() {
         super.prepareForReuse()
         categoryLabel.text = ""
         selectBtn.setImage(UIImage(named: "checkCircle"), for: .normal)
     }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
