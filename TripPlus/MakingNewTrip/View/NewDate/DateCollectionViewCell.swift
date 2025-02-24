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
    
    lazy var centerView: UIView = {
        let view = UIView()
        view.snp.makeConstraints({ make in
            make.width.equalTo(20.0)
            make.height.equalTo(22.0)
        })
        view.layer.cornerRadius = 6.0
        view.backgroundColor = UIColor(named: "tripGreen")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var leftView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "tripGreen")?.withAlphaComponent(0.5)
        view.snp.makeConstraints({ make in
            make.height.equalTo(22.0)
        })
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var rightView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "tripGreen")?.withAlphaComponent(0.5)
        view.snp.makeConstraints({ make in
            make.height.equalTo(22.0)
        })
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
    }
    
    private func setViews(){
        
        
        
        [leftView, rightView].forEach({
            self.contentView.insertSubview($0, at: 0)
        })
        self.contentView.insertSubview(centerView, at: 0)
        
        leftView.snp.makeConstraints({ make in
            make.height.equalTo(22.0)
            make.centerY.equalTo(self.titleLabel.snp.centerY)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview().multipliedBy(0.5)
        })
        
        rightView.snp.makeConstraints({ make in
            make.height.equalTo(22.0)
            make.centerY.equalTo(self.titleLabel.snp.centerY)
            make.trailing.equalToSuperview()
            make.leading.equalTo(leftView.snp.trailing)
        })
        
        centerView.snp.makeConstraints({make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(self.titleLabel.snp.centerY)
        })
        
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
    
    func updateBackImage(_ dateType: SelectedDateType) {
            switch dateType {
            case .singleDate:
                // left right hidden true
                // circle hidden false
                leftView.isHidden = true
                rightView.isHidden = true
                centerView.isHidden = false

            case .firstDate:
                // leftRect hidden true
                // circle, right hidden false
                leftView.isHidden = true
                centerView.isHidden = false
                rightView.isHidden = false

            case .middleDate:
                // circle hidden true
                // left, right hidden false
                centerView.isHidden = true
                leftView.isHidden = false
                rightView.isHidden = false

            case .lastDate:
                // rightRect hidden true
                // circle, left hidden false
                rightView.isHidden = true
                centerView.isHidden = false
                leftView.isHidden = false
            case .notSelectd:
                // all hidden
                centerView.isHidden = true
                leftView.isHidden = true
                rightView.isHidden = true
            }

        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
