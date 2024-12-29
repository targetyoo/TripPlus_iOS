//
//  infoBox.swift
//  TripPlus
//
//  Created by 유대상 on 12/25/24.
//

import Foundation
import UIKit
import SnapKit

class InfoBox: UIView {

    init() {
        super.init(frame: .zero)
        setupViews()
    }
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "PRETENDARD-Regular", size: 12.0)
        label.textColor = UIColor(named: "grayD")
        label.textAlignment = .left
        label.text = "(주)트립플러스"
        label.snp.makeConstraints({ make in
            make.width.equalTo(95.0)
        })
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var ceoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "PRETENDARD-Regular", size: 12.0)
        label.textColor = UIColor(named: "grayD")
        label.textAlignment = .left
        label.text = "대표이사 : 유대상"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var horizenStackView1: UIStackView = {
        let view = UIStackView(arrangedSubviews: [nameLabel, ceoLabel])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alignment = .fill
        view.axis = .horizontal
        view.spacing = 30.0
        return view
    }()
    
    
    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "PRETENDARD-Light", size: 12.0)
        label.textColor = UIColor(named: "grayD")
        label.textAlignment = .natural
        label.text = "주소 \n"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.snp.makeConstraints({ make in
            make.width.equalTo(95.0)
        })
        return label
    }()
    private lazy var addressLabel2: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "PRETENDARD-Light", size: 12.0)
        label.textColor = UIColor(named: "grayD")
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = """
서울특별시 동작구
대방동 어쩌구 어쩌구
"""
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var horizenStackView2: UIStackView = {
        let view = UIStackView(arrangedSubviews: [addressLabel, addressLabel2])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alignment = .fill
        view.axis = .horizontal
        view.spacing = 30.0
        return view
    }()

    
    private lazy var serviceProviderLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "PRETENDARD-Light", size: 12.0)
        label.textColor = UIColor(named: "grayD")
        label.textAlignment = .left
        label.text = "호스팅서비스사업자"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.snp.makeConstraints({ make in
            make.width.equalTo(95.0)
        })
        return label
    }()
    private lazy var serviceProviderLabel2: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "PRETENDARD-Light", size: 12.0)
        label.textColor = UIColor(named: "grayD")
        label.textAlignment = .left
        label.text = "(주)트립플러스파이팅"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var horizenStackView3: UIStackView = {
        let view = UIStackView(arrangedSubviews: [serviceProviderLabel, serviceProviderLabel2])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alignment = .fill
        view.axis = .horizontal
        view.spacing = 30.0
        return view
    }()
    
    
    private lazy var registrationNumberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "PRETENDARD-Light", size: 12.0)
        label.textColor = UIColor(named: "grayD")
        label.textAlignment = .left
        label.text = "사업자둥록번호"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.snp.makeConstraints({ make in
            make.width.equalTo(95.0)
        })
        return label
    }()
    private lazy var registrationNumberLabel2: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "PRETENDARD-Light", size: 12.0)
        label.textColor = UIColor(named: "grayD")
        label.textAlignment = .left
        label.text = "2345678909876543"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var horizenStackView4: UIStackView = {
        let view = UIStackView(arrangedSubviews: [registrationNumberLabel, registrationNumberLabel2])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alignment = .fill
        view.axis = .horizontal
        view.spacing = 30.0
        return view
    }()
    
    
    private lazy var reportNumberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "PRETENDARD-Light", size: 12.0)
        label.textColor = UIColor(named: "grayD")
        label.textAlignment = .left
        label.text = "통신판매업신고번호"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.snp.makeConstraints({ make in
            make.width.equalTo(95.0)
        })
        return label
    }()
    private lazy var reportNumberLabel2: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "PRETENDARD-Light", size: 12.0)
        label.textColor = UIColor(named: "grayD")
        label.textAlignment = .left
        label.text = "010-6666-7777"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var horizenStackView5: UIStackView = {
        let view = UIStackView(arrangedSubviews: [reportNumberLabel, reportNumberLabel2])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alignment = .fill
        view.axis = .horizontal
        view.spacing = 30.0
        return view
    }()
    
    
    private lazy var ascenterLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "PRETENDARD-Light", size: 12.0)
        label.textColor = UIColor(named: "grayD")
        label.textAlignment = .left
        label.text = "고객센터"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.snp.makeConstraints({ make in
            make.width.equalTo(95.0)
        })
        return label
    }()
    private lazy var ascenterLabel2: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "PRETENDARD-Light", size: 12.0)
        label.textColor = UIColor(named: "grayD")
        label.textAlignment = .left
        label.text = "0000-0000"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var horizenStackView6: UIStackView = {
        let view = UIStackView(arrangedSubviews: [ascenterLabel, ascenterLabel2])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alignment = .fill
        view.axis = .horizontal
        view.spacing = 30.0
        return view
    }()
    
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "PRETENDARD-Light", size: 12.0)
        label.textColor = UIColor(named: "grayD")
        label.textAlignment = .left
        label.text = "이메일"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.snp.makeConstraints({ make in
            make.width.equalTo(95.0)
        })
        return label
    }()
    private lazy var emailLabel2: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "PRETENDARD-Light", size: 12.0)
        label.textColor = UIColor(named: "grayD")
        label.textAlignment = .left
        label.text = "target0520@teruten.com"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var horizenStackView7: UIStackView = {
        let view = UIStackView(arrangedSubviews: [emailLabel, emailLabel2])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alignment = .fill
        view.axis = .horizontal
        view.spacing = 30.0
        return view
    }()
    
    private lazy var verticalStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [horizenStackView1, horizenStackView2, horizenStackView3, horizenStackView4, horizenStackView5, horizenStackView6, horizenStackView7])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alignment = .fill
        view.axis = .vertical
        view.spacing = 10.0
        return view
    }()
    
    private func setupViews() {
        self.backgroundColor = UIColor(named: "tripGreen")
        self.addSubview(verticalStackView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        verticalStackView.snp.makeConstraints({ make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(60.0)
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

