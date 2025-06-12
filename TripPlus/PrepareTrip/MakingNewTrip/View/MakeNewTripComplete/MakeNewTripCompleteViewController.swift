//
//  MakeNewTripCompleteViewController.swift
//  TripPlus
//
//  Created by andev on 6/8/25.
//

import Foundation
import UIKit
import SnapKit

class MakeNewTripCompleteViewController: UIViewController{
    
    private lazy var viewTitle: UILabel = {
        let label = UILabel()
        label.text = "여행 만들기"
        label.textColor = UIColor(named: "grayA")
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var completeIcon: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "luggage-43")
        view.contentMode = .scaleAspectFit
        view.tintColor = UIColor(named: "tripGreen")
        view.snp.makeConstraints({make in
            make.width.height.equalTo(56.0)
        })
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var tripNameLabel: UILabel = {
        let label = UILabel()
        label.text = """
"여행 제목"
"""
        label.textColor = UIColor(named: "grayA")
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var createTripNoticeLabel: UILabel = {
        let label = UILabel()
        label.text = "여행이 생성되었어요!"
        label.textColor = UIColor(named: "grayA")
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var inviteFriendsButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor(named: "grayC")
        btn.setTitle("동행자 초대하기", for: .normal)
        btn.setTitleColor(UIColor(named: "grayA"), for: .normal)
        btn.setImage(UIImage(named: "copyLink"), for: .normal)
        btn.tintColor = UIColor(named: "grayA")
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        btn.layer.cornerRadius = 14.0
        btn.semanticContentAttribute = .forceRightToLeft
        btn.imageView?.contentMode = .scaleAspectFit
        btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: -8)
        btn.snp.makeConstraints({ make in
            make.width.equalTo(160.0)
            make.height.equalTo(35.0)
        })
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var confirmBtn: UIButton = {
       let btn = UIButton()
        btn.backgroundColor = UIColor(named: "tripGreen")
        btn.setTitle("확인", for: .normal)
        btn.layer.cornerRadius = DesignSystem.Button.cornerRadius
        btn.setTitleColor(UIColor(named: "grayD"), for: .normal)
        btn.snp.makeConstraints({ make in
            make.height.equalTo(DesignSystem.Button.height)
        })
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
    }
    
    private func setViews(){
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        self.view.backgroundColor = UIColor(named: "grayD")
        
        [viewTitle, completeIcon, tripNameLabel, createTripNoticeLabel, inviteFriendsButton, confirmBtn].forEach({self.view.addSubview($0)})
        
        viewTitle.snp.makeConstraints({ make in
            make.top.equalToSuperview().offset(15.0)
            make.centerX.equalToSuperview()
        })
        
        inviteFriendsButton.snp.makeConstraints({ make in
            make.centerX.centerY.equalToSuperview()
        })
        
        createTripNoticeLabel.snp.makeConstraints({ make in
            make.bottom.equalTo(inviteFriendsButton.snp.top).offset(-20.0)
            make.centerX.equalToSuperview()
        })
        
        tripNameLabel.snp.makeConstraints({ make in
            make.bottom.equalTo(createTripNoticeLabel.snp.top)
            make.leading.equalToSuperview().offset(50.0)
            make.trailing.equalToSuperview().offset(-50.0)
        })
        
        completeIcon.snp.makeConstraints({ make in
            make.bottom.equalTo(tripNameLabel.snp.top).offset(-35.0)
            make.centerX.equalToSuperview()
        })
        
        confirmBtn.snp.makeConstraints({ make in
            make.bottom.equalToSuperview().offset(-50.0)
            make.leading.equalToSuperview().offset(15.0)
            make.trailing.equalToSuperview().offset(-15.0)
        })
    }
}
