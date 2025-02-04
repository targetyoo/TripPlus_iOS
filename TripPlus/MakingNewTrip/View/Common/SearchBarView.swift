//
//  SearchBarView.swift
//  TripPlus
//
//  Created by 유대상 on 1/18/25.
//

import Foundation
import UIKit
import SnapKit

// Used in SelectLocationViewController, SelectCategoryViewController

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
    
    lazy var searchBarBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "grayC")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 14.0
        return view
    }()
    
    lazy var searchBar: UITextField = {
        let txtField = UITextField()
        txtField.textColor = UIColor(named: "grayB")
        txtField.font = UIFont(name: "PRETENDARD-Regular", size: 16.0)
        txtField.placeholder = "장소 검색"
        txtField.translatesAutoresizingMaskIntoConstraints = false
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
        [ searchBarTitle, searchBarBackgroundView, searchBar, searchBarIcon
        ].forEach({ self.addSubview($0) })

        makeConstraint()
    }
    
    private func makeConstraint() {
        searchBarTitle.snp.makeConstraints({ make in
            make.top.leading.equalToSuperview()
        })
        
        searchBarBackgroundView.snp.makeConstraints({ make in
            make.top.equalTo(searchBarTitle.snp.bottom).offset(20.0)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(35.0)
        })
        
        searchBar.snp.makeConstraints({ make in
            make.centerY.equalTo(searchBarBackgroundView.snp.centerY)
            make.leading.equalTo(searchBarBackgroundView.snp.leading).offset(10.0)
            make.trailing.equalTo(searchBarBackgroundView.snp.trailing).offset(-10.0)
            make.height.equalTo(35.0)
        })
        
        searchBarIcon.snp.makeConstraints({ make in
            make.centerY.equalTo(searchBar.snp.centerY)
            make.trailing.equalTo(searchBar.snp.trailing).offset(-5.0)
        })
    }
    
    func configure(type: SEARCH_TYPE){
        // NSAttributedString을 사용하여 placeholder의 색상 설정
        let placeholderColor = UIColor(named: "grayB")!
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: placeholderColor,
            .font: UIFont(name: "PRETENDARD-Regular", size: 16.0)! // 원하는 폰트와 크기
        ]

        switch type {
        case .TYPE_DESTINATION:
            searchBarTitle.text = "여행 장소를 선택해 주세요"
            searchBar.attributedPlaceholder = NSAttributedString(string: "장소 검색", attributes: attributes)
        case .TYPE_CATEGORY:
            searchBarTitle.text = "여행 카테고리를 선택해 주세요"
            searchBar.attributedPlaceholder = NSAttributedString(string: "카테고리 검색", attributes: attributes)
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
