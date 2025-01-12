//
//  MakingNewTripView.swift
//  TripPlus
//
//  Created by 유대상 on 1/11/25.
//

import Foundation
import UIKit
import Combine
import SnapKit

class MakingNewTripView: UIView {
    init() {
        super.init(frame: .zero)
    }
    
    lazy var tripTitleTextView: UITextView = {
        let txtView = UITextView()
        txtView.text = "여행 제목을 입력해 주세요(공백 포함 20자)"
        txtView.font = UIFont(name: "PRETENDARD-Regular", size: 16.0)
        txtView.textColor = UIColor(named: "grayB")
        txtView.isEditable = true
        txtView.isScrollEnabled = false
        txtView.textAlignment = .center
        txtView.textContainerInset = UIEdgeInsets(top: 2, left: 3, bottom: 0, right: 3)
        txtView.translatesAutoresizingMaskIntoConstraints = false
        return txtView
    }()
    
    private lazy var textIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "txtViewIcon")
        icon.tintColor = UIColor(named: "grayB")
        icon.snp.makeConstraints({ make in
            make.height.width.equalTo(24.0)
        })
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    private lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "grayC")
        view.snp.makeConstraints({ make in
            make.height.equalTo(1.0)
        })
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    private lazy var suppliesTypeLabel: UILabel = {
        let label = UILabel()
        label.text = "여행 준비물 타입"
        label.font = UIFont(name: "PRETENDARD-Regular", size: 16.0)
        label.textColor = UIColor(named: "grayB")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var travelPeriodLabel: UILabel = {
        let label = UILabel()
        label.text = "여행 기간"
        label.font = UIFont(name: "PRETENDARD-Regular", size: 16.0)
        label.textColor = UIColor(named: "grayB")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var travelCategoryLabel: UILabel = {
        let label = UILabel()
        label.text = "카테고리"
        label.font = UIFont(name: "PRETENDARD-Regular", size: 16.0)
        label.textColor = UIColor(named: "grayB")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var travelDestinationLabel: UILabel = {
        let label = UILabel()
        label.text = "여행 경로"
        label.font = UIFont(name: "PRETENDARD-Regular", size: 16.0)
        label.textColor = UIColor(named: "grayB")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
//    private lazy var travelCompanionLabel: UILabel = {
//        let label = UILabel()
//        label.text = "동행자"
//        label.font = UIFont(name: "PRETENDARD-Regular", size: 16.0)
//        label.textColor = UIColor(named: "grayB")
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
    
    
    private lazy var suppliesTypeIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "suppliesType")
        icon.tintColor = UIColor(named: "grayB")
        icon.snp.makeConstraints({ make in
            make.height.width.equalTo(24.0)
        })
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    private lazy var travelPeriodIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "travelPeriod")
        icon.tintColor = UIColor(named: "grayB")
        icon.snp.makeConstraints({ make in
            make.height.width.equalTo(24.0)
        })
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    private lazy var travelCategoryIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "travelCategory")
        icon.tintColor = UIColor(named: "grayB")
        icon.snp.makeConstraints({ make in
            make.height.width.equalTo(24.0)
        })
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    private lazy var travelDestinationIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "travelDestination")
        icon.tintColor = UIColor(named: "grayB")
        icon.snp.makeConstraints({ make in
            make.height.width.equalTo(24.0)
        })
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
//    private lazy var travelCompanionIcon: UIImageView = {
//        let icon = UIImageView()
//        icon.image = UIImage(named: "travelCompanion")
//        icon.tintColor = UIColor(named: "grayB")
//        icon.contentMode = .scaleAspectFit
//        icon.snp.makeConstraints({ make in
//            make.height.width.equalTo(24.0)
//        })
//        icon.translatesAutoresizingMaskIntoConstraints = false
//        return icon
//    }()

    
    private lazy var howMuchStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [lessLabel, normalLabel, moreLabel])
        stackView.axis = .horizontal
        stackView.spacing = 7
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var lessLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "grayA")
        label.font = UIFont(name: "PRETENDARD-Regular", size: 16.0)
        label.backgroundColor = UIColor(named: "grayC")
        label.text = "적게"
        label.textAlignment = .center
        label.layer.masksToBounds = true
        label.snp.makeConstraints({ make in
            make.width.equalTo(50)
            make.height.equalTo(30)
            label.layer.cornerRadius = 7
        })
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var normalLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "grayD")
        label.font = UIFont(name: "PRETENDARD-Regular", size: 16.0)
        label.backgroundColor = UIColor(named: "tripGreen")
        label.text = "보통"
        label.textAlignment = .center
        label.layer.masksToBounds = true
        label.snp.makeConstraints({ make in
            make.width.equalTo(50)
            make.height.equalTo(30)
            label.layer.cornerRadius = 7
        })
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var moreLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "grayA")
        label.font = UIFont(name: "PRETENDARD-Regular", size: 16.0)
        label.backgroundColor = UIColor(named: "grayC")
        label.text = "적게"
        label.textAlignment = .center
        label.layer.masksToBounds = true
        label.snp.makeConstraints({ make in
            make.width.equalTo(50)
            make.height.equalTo(30)
            label.layer.cornerRadius = 7
        })
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var setDateButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("dd", for: .normal)
        btn.layer.cornerRadius = 7
        btn.titleLabel?.font = UIFont(name: "PRETENDARD-Regular", size: 16.0)
        btn.setTitleColor(UIColor(named: "grayB"), for: .normal)
        btn.backgroundColor = UIColor(named: "grayC")
        btn.snp.makeConstraints({ make in
            make.width.equalTo(155.0)
        })
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    lazy var setCategoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
//        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        return collectionView
    }()
    
    lazy var setDestinationCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
//        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        return collectionView
    }()
    
//    lazy var setCompanionCollectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collectionView.backgroundColor = .white
////        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
//        return collectionView
//    }()

    
    override func layoutSubviews() {
        super.layoutSubviews()

        [   tripTitleTextView, textIcon, lineView,
            suppliesTypeIcon, suppliesTypeLabel,
            travelPeriodIcon, travelPeriodLabel,
            travelCategoryIcon, travelCategoryLabel,
            travelDestinationIcon, travelDestinationLabel,
//            travelCompanionIcon, travelCompanionLabel,
            howMuchStackView, setDateButton,
            setCategoryCollectionView, setDestinationCollectionView //setCompanionCollectionView,
        ].forEach({ self.addSubview($0) })

        makeConstraint()
        
        setButtonTitleDate()
    }

    
    private func setButtonTitleDate(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy.MM.dd" // 원하는 날짜 형식 설정
        
        let today = Date() // 오늘 날짜 가져오기
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: today)! // 다음 날 계산
        
        let todayString = dateFormatter.string(from: today) // 오늘 날짜 문자열
        let tomorrowString = dateFormatter.string(from: tomorrow) // 다음 날 날짜 문자열
        
        // 버튼 타이틀 설정
        setDateButton.setTitle("\(todayString) → \(tomorrowString)", for: .normal)
    }
    
    private func makeConstraint(){
        tripTitleTextView.snp.makeConstraints({ make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(50.0)
            make.trailing.equalToSuperview().offset(-50.0)
            make.height.equalTo(25.0)
        })
        
        textIcon.snp.makeConstraints({ make in
            make.centerY.equalTo(tripTitleTextView.snp.centerY)
            make.trailing.equalToSuperview().offset(-15.0)
        })
        
        lineView.snp.makeConstraints({ make in
            make.top.equalTo(tripTitleTextView.snp.bottom).offset(20.0)
            make.leading.equalToSuperview().offset(15.0)
            make.trailing.equalToSuperview().offset(-15.0)
        })
        
        suppliesTypeIcon.snp.makeConstraints({ make in
            make.top.equalTo(lineView.snp.bottom).offset(25.0)
            make.leading.equalToSuperview().offset(15.0)
        })
        
        travelPeriodIcon.snp.makeConstraints({ make in
            make.top.equalTo(howMuchStackView.snp.bottom).offset(25.0)
            make.leading.equalToSuperview().offset(15.0)
        })
        
        travelCategoryIcon.snp.makeConstraints({ make in
            make.top.equalTo(setDateButton.snp.bottom).offset(25.0)
            make.leading.equalToSuperview().offset(15.0)
        })
        
        travelDestinationIcon.snp.makeConstraints({ make in
            make.top.equalTo(setCategoryCollectionView.snp.bottom).offset(25.0)
            make.leading.equalToSuperview().offset(15.0)
        })
        
//        travelCompanionIcon.snp.makeConstraints({ make in
//            make.top.equalTo(setDestinationCollectionView.snp.bottom).offset(25.0)
//            make.leading.equalToSuperview().offset(15.0)
//        })
        
        suppliesTypeLabel.snp.makeConstraints({ make in
            make.leading.equalTo(suppliesTypeIcon.snp.trailing).offset(10.0)
            make.centerY.equalTo(suppliesTypeIcon.snp.centerY)
        })
        
        travelPeriodLabel.snp.makeConstraints({ make in
            make.leading.equalTo(travelPeriodIcon.snp.trailing).offset(10.0)
            make.centerY.equalTo(travelPeriodIcon.snp.centerY)
        })
        
        travelCategoryLabel.snp.makeConstraints({ make in
            make.leading.equalTo(travelCategoryIcon.snp.trailing).offset(10.0)
            make.centerY.equalTo(travelCategoryIcon.snp.centerY)
        })
//        travelCompanionLabel.snp.makeConstraints({ make in
//            make.leading.equalTo(travelCompanionIcon.snp.trailing).offset(10.0)
//            make.centerY.equalTo(travelCompanionIcon.snp.centerY)
//        })
        
        travelDestinationLabel.snp.makeConstraints({ make in
            make.leading.equalTo(travelDestinationIcon.snp.trailing).offset(10.0)
            make.centerY.equalTo(travelDestinationIcon.snp.centerY)
        })
        
        
        howMuchStackView.snp.makeConstraints({ make in
            make.trailing.equalToSuperview().offset(-15.0)
            make.centerY.equalTo(suppliesTypeIcon.snp.centerY)
        })
        
        setDateButton.snp.makeConstraints({ make in
            make.trailing.equalToSuperview().offset(-15.0)
            make.centerY.equalTo(travelPeriodIcon.snp.centerY)
        })
        
        setCategoryCollectionView.snp.makeConstraints({ make in
            make.width.equalTo(205.0)
            make.height.equalTo(80.0) //temp
            make.trailing.equalToSuperview().offset(-15.0)
            make.top.equalTo(setDateButton.snp.bottom).offset(25.0)
        })
        
        setDestinationCollectionView.snp.makeConstraints({ make in
            make.width.equalTo(205.0)
            make.height.equalTo(30.0) //temp
            make.trailing.equalToSuperview().offset(-15.0)
            make.top.equalTo(setCategoryCollectionView.snp.bottom).offset(25.0)
        })
        
//        setCompanionCollectionView.snp.makeConstraints({ make in
//            make.width.equalTo(205.0)
//            make.height.equalTo(30.0) //temp
//            make.trailing.equalToSuperview().offset(-15.0)
//            make.top.equalTo(setDestinationCollectionView.snp.bottom).offset(25.0)
//        })
        
        setCategoryCollectionView.backgroundColor = .grayB
        setDestinationCollectionView.backgroundColor = .grayB
//        setCompanionCollectionView.backgroundColor = .grayB
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
