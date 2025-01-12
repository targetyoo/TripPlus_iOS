//
//  MyTripEmpty.swift
//  TripPlus
//
//  Created by 유대상 on 1/3/25.
//

import Foundation
import UIKit

class MyTripEmpty: UIView{
    init() {
        super.init(frame: .zero)
        setupViews()
    }
    
    private lazy var emptyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "PRETENDARD-Regular", size: 16.0)
        label.text = "아직 준비 중인 여행이 없어요"
        label.textColor = UIColor(named: "grayA")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var makeTripBtn: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "plus"), for: .normal)
        button.setTitle("여행 만들기", for: .normal)
        button.titleLabel?.font = UIFont(name: "PRETENDARD-Light", size: 12.0)
        button.setTitleColor(UIColor(named: "grayA"), for: .normal)
        button.configuration = UIButton.Configuration.plain()
        button.configuration?.imagePlacement = .top // 이미지를 위에 배치
        button.configuration?.imagePadding = 10.0 // 이미지와 텍스트 사이 간격
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    
    private func setupViews() {
        [emptyLabel, makeTripBtn].forEach({
            self.addSubview($0)
        })
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        emptyLabel.snp.makeConstraints({ make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(280)
        })
        
        makeTripBtn.snp.makeConstraints({ make in
            make.centerX.equalToSuperview()
            make.top.equalTo(emptyLabel.snp.bottom).offset(12.0)
        })
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
