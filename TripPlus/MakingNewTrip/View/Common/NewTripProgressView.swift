//
//  NewTripProgressView.swift
//  TripPlus
//
//  Created by 유대상 on 3/3/25.
//

import Foundation
import UIKit
import SnapKit

class NewTripProgressView: UIView {
    
    private var progressLabel1: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "1단계\n여행 정보 입력"
        label.textAlignment = .left
        label.font = UIFont(name: "PRETENDARD-Light", size: 12.0)
        label.textColor = UIColor(named: "tripGreen")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var progressLabel2: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "2단계\n준비물 확인"
        label.textAlignment = .left
        label.font = UIFont(name: "PRETENDARD-Light", size: 12.0)
        label.textColor = UIColor(named: "grayB")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var progressLabel3: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "완료"
        label.font = UIFont(name: "PRETENDARD-Light", size: 12.0)
        label.textColor = UIColor(named: "grayB")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var progressPoint1: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = UIColor(named: "tripGreen")
        view.snp.makeConstraints({ make in
            make.width.height.equalTo(16.0)
        })
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 8.0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var progressPoint2: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = UIColor(named: "grayC")
        view.snp.makeConstraints({ make in
            make.width.height.equalTo(16.0)
        })
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 8.0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var progressPoint3 : UIImageView = {
        let view = UIImageView()
        view.backgroundColor = UIColor(named: "grayC")
        view.snp.makeConstraints({ make in
            make.width.height.equalTo(16.0)
        })
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 8.0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    private var progressSubPoint: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "grayC")
        view.snp.makeConstraints({ make in
            make.width.height.equalTo(10.0)
        })
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 5.0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    

    private var progressLine1: UIView = {
        let view = UIView()
        view.snp.makeConstraints({ make in
            make.height.equalTo(4.0)
        })
        view.backgroundColor = UIColor(named: "grayC")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var progressLine2: UIView = {
        let view = UIView()
        view.snp.makeConstraints({ make in
            make.height.equalTo(4.0)
        })
        view.backgroundColor = UIColor(named: "grayC")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    func setupViews(){
        [progressLine1, progressLine2,
         progressLabel1, progressLabel2, progressLabel3,
         progressPoint1, progressPoint2, progressPoint3, progressSubPoint
        ].forEach({self.addSubview($0)})
        
        progressLine1.snp.makeConstraints({make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview().multipliedBy(0.5)
            make.top.equalToSuperview()
        })
        
        progressLine2.snp.makeConstraints({make in
            make.leading.equalTo(progressLine1.snp.trailing)
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
        })
        
        progressPoint1.snp.makeConstraints({ make in
            make.centerY.equalTo(progressLine1.snp.centerY)
            make.leading.equalTo(progressLine1.snp.leading)
        })
        
        progressPoint2.snp.makeConstraints({ make in
            make.centerY.equalTo(progressLine1.snp.centerY)
            make.leading.equalTo(progressLine1.snp.trailing)
        })
        
        progressPoint3.snp.makeConstraints({ make in
            make.centerY.equalTo(progressLine1.snp.centerY)
            make.trailing.equalTo(progressLine2.snp.trailing)
        })
        
        
        progressLabel1.snp.makeConstraints({ make in
            make.top.equalTo(progressPoint1.snp.bottom).offset(5.0)
            make.leading.equalTo(progressPoint1.snp.leading)
        })
        
        progressLabel2.snp.makeConstraints({ make in
            make.top.equalTo(progressPoint2.snp.bottom).offset(5.0)
            make.centerX.equalTo(progressPoint2.snp.centerX)
        })
        
        progressLabel3.snp.makeConstraints({ make in
            make.top.equalTo(progressPoint3.snp.bottom).offset(5.0)
            make.centerX.equalTo(progressPoint3.snp.centerX)
        })
        
        progressSubPoint.snp.makeConstraints({ make in
            make.centerY.centerX.equalTo(progressPoint1.snp.center)
        })
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//    }
    
    func configure(currentProgress: Int) {
        switch currentProgress{
        case 1:
            progressSubPoint.snp.makeConstraints({ make in
                make.center.equalTo(progressPoint1.snp.center)
            })
            progressLabel2.textColor = UIColor(named: "tripGreen")
            progressLabel2.textColor = UIColor(named: "grayB")
            progressLabel3.textColor = UIColor(named: "grayB")
            
            progressLine1.backgroundColor = UIColor(named: "grayC")
            progressLine2.backgroundColor = UIColor(named: "grayC")
            
            progressPoint1.backgroundColor = UIColor(named: "tripGreen")
            progressPoint1.image = nil
            progressPoint2.backgroundColor = UIColor(named: "grayC")
            progressPoint2.image = nil
            progressPoint3.backgroundColor = UIColor(named: "grayC")
            progressPoint3.image = nil
            break;
            
        case 2:
            progressSubPoint.snp.makeConstraints({ make in
                make.center.equalTo(progressPoint2.snp.center)
            })
            
            progressLabel2.textColor = UIColor(named: "tripGreen")
            progressLabel2.textColor = UIColor(named: "tripGreen")
            progressLabel3.textColor = UIColor(named: "grayB")
            
            progressLine1.backgroundColor = UIColor(named: "tripGreen")
            progressLine2.backgroundColor = UIColor(named: "grayC")
            
            progressPoint1.backgroundColor = UIColor(named: "tripGreen")
            progressPoint1.image = UIImage(named: "checkCircle_checked")
            progressPoint2.backgroundColor = UIColor(named: "tripGreen")
            progressPoint2.image = nil
            progressPoint3.backgroundColor = UIColor(named: "grayC")
            progressPoint3.image = nil
            break;
            
        case 3:
            //Animation
            UIView.animate(withDuration: 1.0, animations: {
                self.progressSubPoint.snp.makeConstraints({ make in
                    make.center.equalTo(self.progressPoint3.snp.center)
                })
                self.progressLabel2.textColor = UIColor(named: "tripGreen")
                self.progressLabel2.textColor = UIColor(named: "tripGreen")
                self.progressLabel3.textColor = UIColor(named: "tripGreen")
                
                self.progressLine1.backgroundColor = UIColor(named: "tripGreen")
                self.progressLine2.backgroundColor = UIColor(named: "tripGreen")
                
                self.progressPoint1.backgroundColor = UIColor(named: "tripGreen")
                self.progressPoint1.image = UIImage(named: "checkCircle_checked")
                self.progressPoint2.backgroundColor = UIColor(named: "tripGreen")
                self.progressPoint2.image = UIImage(named: "checkCircle_checked")
                self.progressPoint3.backgroundColor = UIColor(named: "tripGreen")
                self.progressPoint3.image = nil
            })
            
            break;
            
        default:
            break;
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
