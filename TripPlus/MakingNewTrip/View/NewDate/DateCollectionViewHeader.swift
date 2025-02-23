////
////  DateCollectionViewHeader.swift
////  TripPlus
////
////  Created by 유대상 on 2/19/25.
////
//
//import Foundation
//import UIKit
//import FSCalendar
//import SnapKit
//
//class DateCollectionViewHeader: JTACMonthReusableView{
//    static let identifier = "DateCollectionViewHeader"
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupDayLabels() // dayLabel 설정
//    }
//    
//    private var dayLabels: [UILabel] = [] // UILabel 배열
//
//    
//    lazy var dayLabel: UILabel = {
//        let label = UILabel()
//        label.textColor = UIColor(named: "grayA")
//        label.font = UIFont(name: "PRETENDARD-Legular", size: 16.0)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    
//    private func setupDayLabels() {
//           let days = ["일", "월", "화", "수", "목", "금", "토"]
//           
//        let stackView = UIStackView()
//           stackView.axis = .horizontal
//           stackView.distribution = .fillEqually
////           stackView.spacing = 8 // 간격 설정
//           stackView.translatesAutoresizingMaskIntoConstraints = false
//           
//           // 요일 레이블 생성 및 스택 뷰에 추가
//           for day in days {
//               let label = UILabel()
//               label.textColor = UIColor(named: "grayA")
//               label.font = UIFont(name: "PRETENDARD-Regular", size: 16.0)
//               label.text = day
//               label.textAlignment = .center
//               dayLabels.append(label)
//               stackView.addArrangedSubview(label)
//           }
//           
//           addSubview(stackView)
//           
//           stackView.snp.makeConstraints { make in
//               make.edges.equalToSuperview()
//           }
//       }
//    
//    @MainActor required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
