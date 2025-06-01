//
//  MyTripEmptyView.swift
//  TripPlus
//
//  Created by 유대상 on 1/3/25.
//

import Foundation
import UIKit

class MyTripEmptyView: UIView{
    init() {
        super.init(frame: .zero)
        setupViews()
    }
    
    private lazy var emptyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "PRETENDARD-Regular", size: 16.0)
        label.text = "아직 준비 중인 여행이 없어요"
        label.textColor = UIColor(named: "grayA")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var emptyIcon: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "emptyIcon")
        view.tintColor = UIColor(named: "tripGreen")?.withAlphaComponent(0.5)
        view.snp.makeConstraints({ make in
            make.width.height.equalTo(24.0)
        })
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private func setupViews() {
        [emptyLabel, emptyIcon].forEach({
            self.addSubview($0)
        })
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        emptyLabel.snp.makeConstraints({ make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
        })
        
        emptyIcon.snp.makeConstraints({ make in
            make.bottom.equalTo(emptyLabel.snp.top).offset(-10.0)
            make.centerX.equalToSuperview()
        })
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
