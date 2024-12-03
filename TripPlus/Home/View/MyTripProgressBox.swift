//
//  MyTripProgressBox.swift
//  TripPlus
//
//  Created by 유대상 on 11/28/24.
//

import Foundation
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
import UIKit
import SnapKit

class MyTripProgressBox : UIView{
    //실 데이터 사용 시, 주석문을 해제하여 사용
    
//    init(data: YourDataModel) {
    init() {
        super.init(frame: .zero)
//        setupView(with: data)
        setupView()
        self.layer.cornerRadius = 14
        self.backgroundColor = UIColor(named: "grayD")
    }
    

    private lazy var ddayLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "D-00"
        label.font = UIFont(name: "PRETENDARD-Semibold", size: 34)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var progressbarTitle: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "grayA")
        label.text = "여행 준비도"
        label.font = UIFont(name: "PRETENDARD-Light", size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var progressbar: UIProgressView = {
        let bar = UIProgressView()
        bar.progressTintColor = UIColor(named: "tripOrange")
        bar.translatesAutoresizingMaskIntoConstraints = false
        return bar
    }()
    
    private lazy var progressPercent: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "tripGreen")
        label.text = "00%"
        label.font = UIFont(name: "PRETENDARD-Medium", size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var destinationLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "tripGreen")
        label.text = "찬란한 파리"
        label.font = UIFont(name: "PRETENDARD-Semibold", size: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
//    private func setupView(with data: YourDataModel) {
    private func setupView() {
        [ddayLabel, progressbarTitle, progressPercent, progressbar, destinationLabel].forEach({
            self.addSubview($0)
        })
        
        ddayLabel.snp.makeConstraints{ snp in
            snp.leading.top.equalToSuperview().offset(20.0)
        }
        
        progressbar.snp.makeConstraints{ snp in
            snp.leading.bottom.equalToSuperview().offset(20.0)
        }
        
        progressbarTitle.snp.makeConstraints{ snp in
            snp.leading.equalTo(progressbar.snp.leading)
            snp.bottom.equalTo(progressbar.snp.top).offset(5.0)
        }
        
        progressPercent.snp.makeConstraints{ snp in
            snp.trailing.equalTo(progressbar.snp.trailing     )
            snp.bottom.equalTo(progressbar.snp.top).offset(5.0)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
>>>>>>> 3ee07a3 ([UI] 홈 화면 일부 구현)
>>>>>>> 4438042 ([UI] 홈 화면 일부 구현)
