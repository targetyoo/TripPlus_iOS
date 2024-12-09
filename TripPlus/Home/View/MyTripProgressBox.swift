//
//  MyTripProgressBox.swift
//  TripPlus
//
//  Created by 유대상 on 11/28/24.
//

import Foundation
import UIKit
import SnapKit

class MyTripProgressBox : UIView{
    //실 데이터 사용 시, 주석문을 해제하여 사용
    
//    init(data: YourDataModel) {
    init() {
        super.init(frame: .zero)
//        setupView(with: data)
        setupView()
    }
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 14
        view.backgroundColor = UIColor(named: "grayD")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
        label.textColor = .black
        label.text = "찬란한 파리"
        label.font = UIFont(name: "PRETENDARD-Semibold", size: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
//    private func setupView(with data: YourDataModel) {
    private func setupView() {
        
        self.addSubview(contentView)
        
        [ddayLabel, progressbarTitle, progressPercent, progressbar, destinationLabel].forEach({
            self.contentView.addSubview($0)
        })
        
        contentView.snp.makeConstraints({ make in
            make.edges.equalTo(self)
            make.width.equalTo(self)
            make.height.equalTo(150.0)
        })
        contentView에 그림자 넣어야함!
        
        ddayLabel.snp.makeConstraints{ make in
            make.leading.top.equalToSuperview().offset(20.0)
        }
        
        destinationLabel.snp.makeConstraints({ make in
            make.trailing.equalToSuperview().offset(-20.0)
            make.bottom.equalTo(progressbar.snp.bottom)
        })
        
        progressbar.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(20.0)
            make.trailing.equalTo(destinationLabel.snp.leading).offset(-20)
            make.bottom.equalToSuperview().offset(-20.0)
        }
        
        progressbarTitle.snp.makeConstraints{ make in
            make.leading.equalTo(progressbar.snp.leading)
            make.bottom.equalTo(progressbar.snp.top).offset(-5.0)
        }
        
        progressPercent.snp.makeConstraints{ make in
            make.trailing.equalTo(progressbar.snp.trailing)
            make.bottom.equalTo(progressbar.snp.top).offset(-5.0)
        }
        

        
        //TODO: touch 이벤트 추가(self)
    }
    
    func configure(dday: String, percent: Int, destination: String){
        ddayLabel.text = dday
        progressPercent.text = "\(percent)%"
        destinationLabel.text = destination
        progressbar.progress = Float(percent)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
