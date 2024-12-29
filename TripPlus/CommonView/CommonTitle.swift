//
//  CommonTitle.swift
//  TripPlus
//
//  Created by 유대상 on 12/12/24.
//

import Foundation
import UIKit
import SnapKit

class CommonTitle : UIView{
    
    private lazy var contentTitle: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "grayA")
        label.font = UIFont(name: "PRETENDARD-SemiBold", size: 24)
        label.numberOfLines = 0
        label.text = "Common Title"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var contentHeader: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "grayA")
        label.font = UIFont(name: "PRETENDARD-Regular", size: 16)
        label.numberOfLines = 0
        label.text = "Common Header"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var headerStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [contentTitle, contentHeader])
        view.translatesAutoresizingMaskIntoConstraints = false
         view.axis = .vertical
        view.spacing = 10.0
        return view
    }()
    
    init() {
        super.init(frame: .zero)
//        setupView(with: data)
        setupViews()
//        self.layer.cornerRadius = 14
//        self.backgroundColor = UIColor(named: "grayD")
    }
    
    private func setupViews(){
        self.addSubview(headerStackView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        headerStackView.snp.makeConstraints({ make in
            make.edges.equalToSuperview()
        })
    }
    
    
    func configure(title: String, header: String){
        contentTitle.text = title
        contentHeader.text = header
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
