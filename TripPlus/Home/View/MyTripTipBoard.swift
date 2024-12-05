//
//  MyTripTipBoard.swift
//  TripPlus
//
//  Created by 유대상 on 12/5/24.
//

import Foundation
import SnapKit

class MyTripTipBox: UIView{
    
    init() {
        super.init(frame: .zero)
//        setupView(with: data)
        setupViews()
        self.layer.cornerRadius = 14
        self.backgroundColor = UIColor(named: "grayD")
    }
    
    private func setupViews(){
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
