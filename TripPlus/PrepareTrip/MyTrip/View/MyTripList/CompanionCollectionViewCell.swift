//
//  CompanionCollectionViewCell.swift
//  TripPlus
//
//  Created by andev on 6/14/25.
//

import Foundation
import UIKit
import SnapKit

class CompanionCollectionViewCell: UICollectionViewCell {
    static var identifier: String = "CompanionCollectionViewCell"
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = UIColor(named: "grayA")
        label.text = "사용자"
        label.textAlignment = .center
        label.backgroundColor = UIColor(named: "grayC")
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func setViews(){
        self.contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints({ make in
            make.edges.equalToSuperview()
        })
    }
    
    func configure(name: String) {
        nameLabel.text = name
        nameLabel.layer.cornerRadius = 14.0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
