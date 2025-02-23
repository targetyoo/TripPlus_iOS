//
//  DateCollectionViewCell.swift
//  TripPlus
//
//  Created by 유대상 on 2/9/25.
//

import Foundation
import UIKit
import Combine
import FSCalendar

class DateCollectionViewCell: FSCalendarCell{
    static let identifier = "DateCollectionViewCell"
    private var cancellables = Set<AnyCancellable>()
    
//    lazy var dateLabel: UILabel = {
//        let label = UILabel()
//        label.font = UIFont(name: "PRETENDARD-Regular", size: 16.0)
//        label.textColor = UIColor(named: "grayB")
//        label.textAlignment = .center
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    
//    lazy var selectedView: UIView = {
//        let view = UIView()
//        view.isHidden = true
//        view.layer.cornerRadius = 6.0
//        view.backgroundColor = UIColor(named: "tripGreen")
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
    }
    
    private func setViews(){
//        self.addSubview(dateLabel)
//        self.addSubview(selectedView)
//
//        dateLabel.snp.makeConstraints({ make in
//            make.width.equalTo(22.0)
//            make.height.equalTo(28.0)
//            make.centerY.centerX.equalToSuperview()
//        })
//        
//        selectedView.snp.makeConstraints({ make in
//            make.edges.equalTo(dateLabel)
//        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
