//
//  MyTripProgressBoard.swift
//  TripPlus
//
//  Created by 유대상 on 11/28/24.
//

import Foundation
import UIKit

class MyTripSuppliesBoard : UIView{
    //실 데이터 사용 시, 주석문을 해제하여 사용
    
//    init(data: YourDataModel) {
    init() {
        super.init(frame: .zero)
//        setupView(with: data)
        setupView()
        self.layer.cornerRadius = 14
        self.backgroundColor = UIColor(named: "grayD")
    }
    
    private lazy var : = {
        .translatesAutoresizingMaskIntoConstraints = false
        return
    }()
    private lazy var : = {
        .translatesAutoresizingMaskIntoConstraints = false
        return
    }()
    
//    private func setupView(with data: YourDataModel) {
    private func setupView() {
        // 서브뷰 생성 및 레이아웃 설정
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
