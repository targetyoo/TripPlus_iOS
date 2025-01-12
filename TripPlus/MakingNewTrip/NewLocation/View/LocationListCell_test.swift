//
//  LocationListCell.swift
//  TripPlus
//
//  Created by 유대상 on 9/22/24.
//

import Foundation
import UIKit
import SnapKit

class LocationListCell: UITableViewCell {
    let cityLabel = UILabel()
    let countryLabel = UILabel()
    let checkBtn = UIButton()

    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        cityLabel.font = UIFont(name: "Pretendard-Regular", size: 16.0)
        countryLabel.font = UIFont(name: "Pretendard-Light", size: 12.0)
        
        [cityLabel, countryLabel, checkBtn].forEach{contentView.addSubview($0)}
        
        cityLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(15.0)
            $0.top.equalToSuperview().inset(15.0)
        }
        
        countryLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(15.0)
            $0.top.equalTo(cityLabel.snp.bottom).inset(15.0)
        }
        
        checkBtn.snp.makeConstraints{
            $0.trailing.equalToSuperview().inset(15.0)
            $0.centerY.equalToSuperview()
        }
    }
    
    func setData(_ data: LocationListCellData){
        cityLabel.text = data.city
        countryLabel.text = data.country
        if data.isChecked{
            checkBtn.setImage(UIImage(named: "checkCircle_checked"), for: .normal)
        }else{
            checkBtn.setImage(UIImage(named: "checkCircle"), for: .normal)
        }
    }
}
