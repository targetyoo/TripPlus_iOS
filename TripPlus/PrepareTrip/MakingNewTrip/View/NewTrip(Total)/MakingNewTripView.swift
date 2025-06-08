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
    
    lazy var tripTitleTextView: UITextField = {
        let txtField = UITextField()
        txtField.placeholder = "여행 제목을 입력해 주세요(공백 포함 20자)."
        txtField.backgroundColor = .white
        txtField.font = UIFont(name: "PRETENDARD-Regular", size: 16.0)
        txtField.textColor = UIColor(named: "grayA")
        txtField.returnKeyType = .done
        txtField.backgroundColor = UIColor(named: "grayC")
        txtField.textAlignment = .left
        txtField.translatesAutoresizingMaskIntoConstraints = false
        return txtField
    }()
    
    private lazy var textViewBackground: UIView = {
        let view = UIView()
        view.snp.makeConstraints({ make in
            make.height.equalTo(35.0)
        })
        view.layer.cornerRadius = 14.0
        view.backgroundColor = UIColor(named: "grayC")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var textIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "txtViewIcon")
        icon.tintColor = UIColor(named: "grayB")
        icon.snp.makeConstraints({ make in
            make.height.width.equalTo(DesignSystem.Common.icon_size)
        })
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
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
    
    private lazy var travellocationLabel: UILabel = {
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
            make.height.width.equalTo(DesignSystem.Common.icon_size)
        })
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    private lazy var travelPeriodIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "travelPeriod")
        icon.tintColor = UIColor(named: "grayB")
        icon.snp.makeConstraints({ make in
            make.height.width.equalTo(DesignSystem.Common.icon_size)
        })
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    private lazy var travelCategoryIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "travelCategory")
        icon.tintColor = UIColor(named: "grayB")
        icon.snp.makeConstraints({ make in
            make.height.width.equalTo(DesignSystem.Common.icon_size)
        })
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    private lazy var travelLocationIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "travellocation")
        icon.tintColor = UIColor(named: "grayB")
        icon.snp.makeConstraints({ make in
            make.height.width.equalTo(DesignSystem.Common.icon_size)
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

    
    private lazy var typeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [lessLabel, normalLabel, moreLabel])
        stackView.axis = .horizontal
        stackView.spacing = 7
        stackView.isUserInteractionEnabled = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let lessLabelTGR = UITapGestureRecognizer()
    lazy var lessLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "grayA")
        label.font = UIFont(name: "PRETENDARD-Regular", size: 16.0)
        label.backgroundColor = UIColor(named: "grayC")
        label.text = "적게"
        label.textAlignment = .center
        label.layer.masksToBounds = true
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(lessLabelTGR)
        label.snp.makeConstraints({ make in
            make.width.equalTo(55)
            make.height.equalTo(30)
            label.layer.cornerRadius = DesignSystem.Badge.cornerRadius
        })
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let normalLabelTGR = UITapGestureRecognizer()
    lazy var normalLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "grayD")
        label.font = UIFont(name: "PRETENDARD-Regular", size: 16.0)
        label.backgroundColor = UIColor(named: "tripGreen")
        label.text = "보통"
        label.textAlignment = .center
        label.layer.masksToBounds = true
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(normalLabelTGR)
        label.snp.makeConstraints({ make in
            make.width.equalTo(55)
            make.height.equalTo(30)
            label.layer.cornerRadius = DesignSystem.Badge.cornerRadius
        })
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let moreLabelTGR = UITapGestureRecognizer()
    lazy var moreLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "grayA")
        label.font = UIFont(name: "PRETENDARD-Regular", size: 16.0)
        label.backgroundColor = UIColor(named: "grayC")
        label.text = "많이"
        label.textAlignment = .center
        label.layer.masksToBounds = true
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(moreLabelTGR)
        label.snp.makeConstraints({ make in
            make.width.equalTo(55)
            make.height.equalTo(30)
            label.layer.cornerRadius = DesignSystem.Badge.cornerRadius
        })
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    lazy var setDateButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("dd", for: .normal)
        btn.layer.cornerRadius = DesignSystem.Badge.cornerRadius
        btn.titleLabel?.font = UIFont(name: "PRETENDARD-Regular", size: 16.0)
        btn.setTitleColor(UIColor(named: "grayB"), for: .normal)
        btn.backgroundColor = UIColor(named: "grayC")
        btn.snp.makeConstraints({ make in
            make.width.equalTo(170.0)
        })
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    lazy var setCategoryCollectionView: UICollectionView = {
        let layout = RightAlignedFlowLayout()
        layout.minimumLineSpacing = 10.0
        layout.minimumInteritemSpacing = 10.0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.isScrollEnabled = false
        collectionView.register(RightAlignedCollectionViewCell.self, forCellWithReuseIdentifier: RightAlignedCollectionViewCell.identifier)
        collectionView.register(AddItemCell.self, forCellWithReuseIdentifier: AddItemCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    lazy var setLocationCollectionView: UICollectionView = {
        let layout = RightAlignedFlowLayout()
        layout.minimumLineSpacing = 10.0
        layout.minimumInteritemSpacing = 10.0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.isScrollEnabled = false
        collectionView.register(RightAlignedCollectionViewCell.self, forCellWithReuseIdentifier: RightAlignedCollectionViewCell.identifier)
        collectionView.register(AddItemCell.self, forCellWithReuseIdentifier: AddItemCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false

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

        [   textViewBackground, tripTitleTextView, textIcon,
            suppliesTypeIcon, suppliesTypeLabel,
            travelPeriodIcon, travelPeriodLabel,
            travelCategoryIcon, travelCategoryLabel,
            travelLocationIcon, travellocationLabel,
//            travelCompanionIcon, travelCompanionLabel,
            typeStackView, setDateButton,
            setCategoryCollectionView, setLocationCollectionView, //setCompanionCollectionView,
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
        
        textViewBackground.snp.makeConstraints({ make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(15.0)
            make.trailing.equalToSuperview().offset(-15.0)
        })
        
        tripTitleTextView.snp.makeConstraints({ make in
            make.centerY.equalTo(textViewBackground.snp.centerY)
            make.leading.equalTo(textViewBackground.snp.leading).offset(13.0)
            make.trailing.equalTo(textIcon.snp.leading).offset(-5.0)
        })
        
        textIcon.snp.makeConstraints({ make in
            make.centerY.equalTo(textViewBackground.snp.centerY)
            make.trailing.equalToSuperview().offset(-25.0)
        })
        
        
        suppliesTypeIcon.snp.makeConstraints({ make in
            make.top.equalTo(tripTitleTextView.snp.bottom).offset(25.0)
            make.leading.equalToSuperview().offset(15.0)
        })
        
        travelPeriodIcon.snp.makeConstraints({ make in
            make.top.equalTo(typeStackView.snp.bottom).offset(25.0)
            make.leading.equalToSuperview().offset(15.0)
        })
        
        travelCategoryIcon.snp.makeConstraints({ make in
            make.top.equalTo(setDateButton.snp.bottom).offset(25.0)
            make.leading.equalToSuperview().offset(15.0)
        })
        
        travelLocationIcon.snp.makeConstraints({ make in
            make.top.equalTo(setCategoryCollectionView.snp.bottom).offset(25.0)
            make.leading.equalToSuperview().offset(15.0)
        })
        
//        travelCompanionIcon.snp.makeConstraints({ make in
//            make.top.equalTo(setlocationCollectionView.snp.bottom).offset(25.0)
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
        
        travellocationLabel.snp.makeConstraints({ make in
            make.leading.equalTo(travelLocationIcon.snp.trailing).offset(10.0)
            make.centerY.equalTo(travelLocationIcon.snp.centerY)
        })
        
        
        typeStackView.snp.makeConstraints({ make in
            make.trailing.equalToSuperview().offset(-15.0)
            make.centerY.equalTo(suppliesTypeIcon.snp.centerY)
        })
        
        setDateButton.snp.makeConstraints({ make in
            make.trailing.equalToSuperview().offset(-15.0)
            make.centerY.equalTo(travelPeriodIcon.snp.centerY)
        })
        
        setCategoryCollectionView.snp.makeConstraints({ make in
            make.width.equalTo(205.0)
//            make.height.equalTo(30.0)
            make.trailing.equalToSuperview().offset(-15.0)
            make.top.equalTo(setDateButton.snp.bottom).offset(25.0)
        })
        
        setLocationCollectionView.snp.makeConstraints({ make in
            make.width.equalTo(205.0)
//            make.height.equalTo(30.0)
            make.trailing.equalToSuperview().offset(-15.0)
            make.top.equalTo(setCategoryCollectionView.snp.bottom).offset(25.0)
        })
        
//        setCompanionCollectionView.snp.makeConstraints({ make in
//            make.width.equalTo(205.0)
//            make.height.equalTo(30.0) //temp
//            make.trailing.equalToSuperview().offset(-15.0)
//            make.top.equalTo(setlocationCollectionView.snp.bottom).offset(25.0)
//        })
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
