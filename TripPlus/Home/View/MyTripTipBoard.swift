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
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [commonTitle, tipBox])
        view.axis = .vertical
        view.spacing = 10
        view.distribution = .fill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var commonTitle: CommonTitle = {
        let view = CommonTitle()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var tipBox: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "grayC")
        view.layer.cornerRadius = 14
        view.snp.makeConstraints { make in
            make.height.equalTo(70)
        }
        return view
    }()
    
    private lazy var tipBox_leadingIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "tip_Star")
        imageView.tintColor = .black
        imageView.snp.makeConstraints { make in
            make.height.width.equalTo(24)
        }
        return imageView
    }()
    
    private lazy var tipBox_text: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "grayA")
        label.font = UIFont(name: "PRETENDARD-Regular", size: 16)
        label.numberOfLines = 1
        label.text = "Text"
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var tipBox_trailingIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "tip_arrow")
        imageView.tintColor = .black
        imageView.snp.makeConstraints { make in
            make.width.equalTo(4)
            make.height.equalTo(8)
        }
        return imageView
    }()
    
    
    private func setupViews(){
//        [commonTitle, tipBox].forEach({
//            self.addSubview($0)
//        })
        self.addSubview(stackView)

        [tipBox_leadingIcon, tipBox_text, tipBox_trailingIcon].forEach({
            self.tipBox.addSubview($0)
        })
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        stackView.snp.makeConstraints({ make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
        })
        
//        commonTitle.snp.makeConstraints({ make in
//            make.top.equalToSuperview()
//            make.leading.equalToSuperview().offset(15)
//        })
//
//        tipBox.snp.makeConstraints({ make in
//            make.top.equalTo(commonTitle.snp.bottom).offset(20)
//            make.leading.equalToSuperview().offset(10)
//            make.trailing.equalToSuperview().offset(-10)
//        })
        
        tipBox_leadingIcon.snp.makeConstraints({ make in
            make.leading.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
        })
        
        tipBox_text.snp.makeConstraints({ make in
            make.leading.equalTo(tipBox_leadingIcon.snp.trailing).offset(20)
            make.trailing.equalTo(tipBox_trailingIcon.snp.leading).offset(-20)
            make.centerY.equalToSuperview()
//            make.width.lessThanOrEqualTo(215)
        })
        
        tipBox_trailingIcon.snp.makeConstraints({ make in
            make.trailing.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
        })
        
        //TODO: Touch 이벤트 추가(TipBox)
    }
    
    func configure(description: String){
        tipBox_text.text = description
    }
    
    func configureTitle(title: String, headline: String){
        commonTitle.configure(title: title, header: headline)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
