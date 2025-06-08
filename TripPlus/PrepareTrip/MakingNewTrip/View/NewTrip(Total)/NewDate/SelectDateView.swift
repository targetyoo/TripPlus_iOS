//
//  SelectDateView.swift
//  TripPlus
//
//  Created by 유대상 on 2/9/25.
//

import Foundation
import UIKit
import FSCalendar


enum SelectedDateType {
    case singleDate    // 날짜 하나만 선택된 경우 (원 모양 배경)
    case firstDate    // 여러 날짜 선택 시 맨 처음 날짜
    case middleDate // 여러 날짜 선택 시 맨 처음, 마지막을 제외한 중간 날짜
    case lastDate   // 여러 날짜 선택시 맨 마지막 날짜
    case notSelectd // 선택되지 않은 날짜
}


class SelectDateView: UIView{
    init() {
        super.init(frame: .zero)
    }
    
    lazy var calendarView: FSCalendar = {
        let view = FSCalendar()
        
        view.register(DateCollectionViewCell.self, forCellReuseIdentifier: DateCollectionViewCell.identifier)
//        view.register(DateCollectionViewHeader.self, forSupplementaryViewOfKind: JTACMonthView.elementKindSectionHeader, withReuseIdentifier: DateCollectionViewHeader.identifier)
        view.allowsMultipleSelection = true
        view.appearance.selectionColor = .clear
        view.scrollDirection = .horizontal
        view.today = nil
//        view.appearance.todayColor = UIColor(named: "tripOrange")
        view.weekdayHeight = 22
        view.locale = Locale(identifier: "ko_KR")
        view.headerHeight = 0
        view.collectionView.automaticallyAdjustsScrollIndicatorInsets = false
        view.appearance.titleFont = DesignSystem.Calendar.font
        view.appearance.titleDefaultColor = DesignSystem.Calendar.thisMonth_fontColor
        view.appearance.weekdayFont = DesignSystem.Calendar.font
        view.appearance.weekdayTextColor = DesignSystem.Calendar.thisMonth_fontColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var departureDateLabel: UILabel = {
        let label = UILabel()
        label.text = "출발일"
        label.font = DesignSystem.Calendar.button_font
        label.textColor = UIColor(named: "grayA")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var arrivalDateLabel: UILabel = {
        let label = UILabel()
        label.text = "도착일"
        label.font = DesignSystem.Calendar.button_font
        label.textColor =  DesignSystem.Calendar.thisMonth_fontColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    lazy var departureDateBtn: UIButton = {
        let btn = UIButton()
        btn.layer.masksToBounds = false
        btn.layer.cornerRadius = DesignSystem.Calendar.button_CornerRadius
        btn.setTitle("0000년 00월 00일", for: .normal)
        btn.titleLabel?.font =  DesignSystem.Calendar.font
        btn.setTitleColor(UIColor(named: "grayA"), for: .normal)
        btn.layer.borderColor = DesignSystem.Calendar.button_Selected_BorderColor.cgColor
        btn.backgroundColor = DesignSystem.Calendar.button_Selected_BackgroundColor
        btn.isUserInteractionEnabled = false
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    lazy var arrivalDateBtn: UIButton = {
        let btn = UIButton()
        btn.layer.masksToBounds = false
        btn.layer.cornerRadius = DesignSystem.Calendar.button_CornerRadius
        btn.setTitle("9999년 99월 99일", for: .normal)
        btn.titleLabel?.font = DesignSystem.Calendar.font
        btn.setTitleColor(DesignSystem.Calendar.button_Unselected_FontColor, for: .normal)
        btn.layer.borderColor = DesignSystem.Calendar.button_Selected_BorderColor.cgColor
        btn.backgroundColor = DesignSystem.Calendar.button_Unselected_BackgroundColor
        btn.isUserInteractionEnabled = false
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var verticalStackView1: UIStackView = {
        let view = UIStackView(arrangedSubviews: [departureDateLabel, departureDateBtn])
        view.axis = .vertical
        view.spacing = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var verticalStackView2: UIStackView = {
        let view = UIStackView(arrangedSubviews: [arrivalDateLabel, arrivalDateBtn])
        view.axis = .vertical
        view.spacing = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var horizontalStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [verticalStackView1, verticalStackView2])
        view.axis = .horizontal
        view.spacing = 20
        view.distribution = .fillEqually
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
     lazy var cancelBtn: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = DesignSystem.Button.cornerRadius
        btn.setTitle("닫기", for: .normal)
        btn.titleLabel?.font = UIFont(name: "PRETENDARD-Regular", size: 16.0)
        btn.setTitleColor(DesignSystem.Button.close_FontColor, for: .normal)
        btn.backgroundColor = DesignSystem.Button.close_BackgroundColor
        btn.snp.makeConstraints({ make in
            make.height.equalTo(DesignSystem.Button.height)
        })
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
     lazy var confirmBtn: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = DesignSystem.Button.cornerRadius
        btn.setTitle("확인", for: .normal)
        btn.titleLabel?.font = UIFont(name: "PRETENDARD-Regular", size: 16.0)
         btn.setTitleColor(DesignSystem.Button.close_FontColor, for: .normal)
         btn.backgroundColor = DesignSystem.Button.close_BackgroundColor
        btn.snp.makeConstraints({ make in
            make.height.equalTo(DesignSystem.Button.height)
        })
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var horizontalStackView2: UIStackView = {
        let view = UIStackView(arrangedSubviews: [cancelBtn, confirmBtn])
        view.axis = .horizontal
        view.spacing = 20.0
        view.distribution = .fillEqually
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    lazy var monthLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "grayA")
        label.font = UIFont(name: "PRETENDARD-Legular", size: 16.0)
        label.text = "0000년 00월"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var previousMonthBtn: UIButton = {
        let btn = UIButton()
        btn.snp.makeConstraints({ make in
            make.width.height.equalTo(DesignSystem.Common.icon_size)
        })
        btn.setImage(UIImage(named: "arrow_right"), for: .normal)
        btn.tintColor = UIColor(named: "grayA")
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    lazy var nextMonthBtn: UIButton = {
        let btn = UIButton()
        btn.snp.makeConstraints({ make in
            make.width.height.equalTo(DesignSystem.Common.icon_size)
        })
        btn.setImage(UIImage(named: "arrow_left"), for: .normal)
        btn.tintColor = UIColor(named: "grayA")
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        [ horizontalStackView, calendarView, monthLabel, previousMonthBtn, nextMonthBtn, horizontalStackView2 ].forEach({ self.addSubview($0) })
        
        horizontalStackView.snp.makeConstraints({ make in
            make.top.leading.equalToSuperview().offset(20.0)
            make.trailing.equalToSuperview().offset(-20.0)
        })
        
        monthLabel.snp.makeConstraints({ make in
            make.top.equalTo(horizontalStackView.snp.bottom).offset(20.0)
            make.leading.equalToSuperview().offset(20.0)
        })
        
        nextMonthBtn.snp.makeConstraints({ make in
            make.top.equalTo(horizontalStackView.snp.bottom).offset(20.0)
            make.trailing.equalToSuperview().offset(-20.0)
        })
        
        previousMonthBtn.snp.makeConstraints({ make in
            make.top.equalTo(horizontalStackView.snp.bottom).offset(20.0)
            make.trailing.equalTo(nextMonthBtn.snp.leading).offset(-10)
        })
        
        calendarView.snp.makeConstraints({ make in
            make.top.equalTo(monthLabel.snp.bottom).offset(15.0)
            make.leading.equalToSuperview().offset(20.0)
            make.trailing.equalToSuperview().offset(-20.0)
            make.height.equalTo(240.0)
        })
        
        horizontalStackView2.snp.makeConstraints({ make in
            make.leading.equalToSuperview().offset(20.0)
            make.trailing.equalToSuperview().offset(-20.0)
            make.top.equalTo(calendarView.snp.bottom).offset(15.0)
        })
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
