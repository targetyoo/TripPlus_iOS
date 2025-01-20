//
//  SearchBarView.swift
//  TripPlus
//
//  Created by 유대상 on 1/18/25.
//

import Foundation
import UIKit
import SnapKit


enum SEARCH_TYPE{
    case TYPE_DESTINATION
    case TYPE_CATEGORY
}

class SearchBarView: UIView{
    init() {
        super.init(frame: .zero)
    }
    
    private lazy var searchBarTitle: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "grayA")
        label.font = UIFont(name: "PRETENDARD-Medium", size: 20.0)
        label.text = "여행 장소를 선택해 주세요"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var searchBar: UITextField = {
        let txtField = UITextField()
        txtField.backgroundColor = UIColor(named: "grayC")
        txtField.textColor = UIColor(named: "grayA")
        txtField.font = UIFont(name: "PRETENDARD-Regular", size: 16.0)
        txtField.placeholder = "장소 검색"
        txtField.translatesAutoresizingMaskIntoConstraints = false
        txtField.layer.masksToBounds = true
        txtField.layer.cornerRadius = 14.0
        return txtField
    }()
    
    private lazy var searchBarIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "searchBarIcon")
        imageView.tintColor = UIColor(named: "grayB")
        imageView.snp.makeConstraints({ make in
            make.width.height.equalTo(24.0)
        })
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        [ searchBarTitle, searchBar, searchBarIcon
        ].forEach({ self.addSubview($0) })

        makeConstraint()
    }
    
    private func makeConstraint() {
        searchBarTitle.snp.makeConstraints({ make in
            make.top.leading.equalToSuperview()
        })
        
        searchBar.snp.makeConstraints({ make in
            make.top.equalTo(searchBarTitle.snp.bottom).offset(5.0)
            make.leading.trailing.equalToSuperview()
        })
        
        searchBarIcon.snp.makeConstraints({ make in
            make.centerY.equalTo(searchBar.snp.centerY)
            make.trailing.equalTo(searchBar.snp.trailing).offset(5.0)
        })
    }
    
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
