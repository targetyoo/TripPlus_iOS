//
//  MyTripTipBoard.swift
//  TripPlus
//
//  Created by 유대상 on 12/5/24.
//

import Foundation
import UIKit
import SnapKit

class MyTripTipBoard: UIView{
    
    init() {
        super.init(frame: .zero)
//        setupView(with: data)
        setupViews()
//        self.layer.cornerRadius = 14
//        self.backgroundColor = UIColor(named: "grayD")
    }
    
    private lazy var tipHeader: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "grayA")
        label.font = UIFont(name: "PRETENDARD-SemiBold", size: 24)
        label.numberOfLines = 0
        label.text = "여행 가는 ~~ 관련 톡"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var tipHeader2: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "grayA")
        label.font = UIFont(name: "PRETENDARD-Regular", size: 16)
        label.numberOfLines = 0
        label.text = "톡만 모았어요"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var tipBox: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "grayC")
        view.layer.cornerRadius = 14
        return view
    }()
    
    private lazy var tipBox_leadingIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "tip_Star")
        imageView.snp.makeConstraints { make in
            make.height.width.equalTo(24)
        }
        return imageView
    }()
    
    private lazy var tipBox_text: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "grayA")
        label.font = UIFont(name: "PRETENDARD-Regular", size: 16)
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var tipBox_trailingIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "tip_arrow")
        imageView.snp.makeConstraints { make in
            make.height.width.equalTo(24)
        }
        return imageView
    }()
    
    
    private func setupViews(){
        [tipHeader, tipHeader2, tipBox].forEach({
            self.addSubview($0)
        })
        
        [tipBox_leadingIcon, tipBox_text, tipBox_trailingIcon].forEach({
            self.tipBox.addSubview($0)
        })
        
        tipHeader.snp.makeConstraints({ make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(15)
        })
        
        tipHeader2.snp.makeConstraints({ make in
            make.top.equalTo(tipHeader.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(15)
        })
        
        tipBox.snp.makeConstraints({ make in
            make.top.equalTo(tipHeader2.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().offset(10)
            make.height.equalTo(72)
        })
        
        tipBox_leadingIcon.snp.makeConstraints({ make in
            make.leading.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
        })
        
        tipBox_text.snp.makeConstraints({ make in
            make.leading.equalTo(tipBox_leadingIcon.snp.trailing).offset(20)
            make.centerY.equalToSuperview()
        })
        
        tipBox_trailingIcon.snp.makeConstraints({ make in
            make.trailing.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
        })
        
        //TODO: Touch 이벤트 추가(TipBox)
    }
    
    func configure(username: String, destination: String , description: String){
        tipBox_text.text = description
        tipHeader.text = "여행 가는 \(destination) 관련 톡"
        tipHeader2.text = "\(username)님을 위한 \(description)톡만 모았어요"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
