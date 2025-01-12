//
//  MyTripEmptyView.swift
//  TripPlus
//
//  Created by 유대상 on 1/3/25.
//

import Foundation
import UIKit

class MyTripEmptyView: UIView{
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
//        let button = UIButton()
//        button.contentVerticalAlignment = .bottom
//        button.setTitle("여행 만들기", for: .normal)
//        button.setTitleColor(UIColor(named: "grayA"), for: .normal)
//        button.titleLabel?.font = UIFont(name: "PRETENDARD-Light", size: 12.0)
//        button.tintColor = UIColor(named: "tripGreen")
//        button.setImage(UIImage(named: "plus"), for: .normal)
//
//        let spacing: CGFloat = 10
//        button.imageView?.contentMode = .scaleAspectFit
//        
//        button.imageEdgeInsets = UIEdgeInsets(top: -button.titleLabel!.intrinsicContentSize.height - spacing, left: 0, bottom: 0, right: -button.titleLabel!.intrinsicContentSize.width)
//        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: -button.imageView!.frame.size.width, bottom: -button.imageView!.frame.size.height - spacing, right: 0)
//        
//        return button
            
//        button.setImage(UIImage(named: "plus"), for: .normal)
//        button.setTitleColor(UIColor(named: "grayA"), for: .normal)
//        button.setTitleColor(UIColor(named: "grayA"), for: .highlighted)
//        button.setTitleColor(UIColor(named: "grayA"), for: .selected)
//        button.configuration = UIButton.Configuration.plain()
        
        var configuration = UIButton.Configuration.plain()
        configuration.title = "여행 만들기"
        configuration.baseForegroundColor = UIColor(named: "tripGreen")
        configuration.image = UIImage(named: "plus")
        configuration.imagePlacement = .top // 이미지를 위에 배치
        configuration.imagePadding = 10.0 // 이미지와 텍스트 사이 간격
        
        let font = UIFont(name: "PRETENDARD-Light", size: 12.0)!
        configuration.attributedTitle = AttributedString("여행 만들기", attributes: AttributeContainer([.font: font]))
        
        let button = UIButton(configuration: configuration, primaryAction: nil)
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
            make.top.equalToSuperview()
        })
        
        makeTripBtn.snp.makeConstraints({ make in
            make.centerX.equalToSuperview()
            make.top.equalTo(emptyLabel.snp.bottom).offset(12.0)
        })
        
//        makeTripBtn.titleLabel?.font = UIFont(name: "PRETENDARD-Light", size: 12.0)
        
//        makeTripBtn.titleLabel?.textColor = UIColor(named: "grayA")
//        makeTripBtn.tintColor = UIColor(named: "tripGreen")
//        makeTripBtn.imageView?.tintColor = UIColor(named: "tripGreen")

        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
