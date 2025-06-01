//
//  PackageListTableViewCell.swift
//  TripPlus
//
//  Created by 유대상 on 5/30/25.
//

import Foundation
import UIKit
import SnapKit

class PackageTableViewCell: UITableViewCell {
    static let identifier = "PackageTableViewCell"
    
//    var onInfoButtonTapped: (() -> Void)?
    var onInfoButtonTapped: ((UIButton) -> Void)?
    
    private let iconImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.tintColor = .black
        imgView.snp.makeConstraints({ make in
            make.width.height.equalTo(24)
        })
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        label.snp.makeConstraints({ make in
            make.height.equalTo(24)
        })
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let infoButton: UIButton = {
        let btn = UIButton(type: .infoLight)
        btn.tintColor = .gray
        btn.snp.makeConstraints({ make in
            make.width.height.equalTo(24)
        })
        return btn
    }()
    
    private let borderline: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray //Temp
        view.snp.makeConstraints({ make in
            make.height.equalTo(0.5)
        })
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let descriptionTitle: UILabel = {
        let label = UILabel()
        label.text = "이 준비물이 추천된 이유"
        label.font = .systemFont(ofSize: 14)  //Temp
        label.textColor = .black              //Temp
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionBody: UILabel = {
        let label = UILabel()
        label.text = "Description Body for Cell \nDescription Body for Cell"
        label.font = .systemFont(ofSize: 14) //Temp
        label.textColor = .black             //Temp
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var verticalStackView: UIView = {
        let stackView = UIView()
        stackView.backgroundColor = .lightGray
        stackView.layer.cornerRadius = 5.0
        stackView.isHidden = true //기본값은 숨김처리
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    // 초기화
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
  
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        setupViews()
//    }
    
    private func setupViews() {
        self.contentView.backgroundColor = .white
        [iconImageView, titleLabel, infoButton, borderline, verticalStackView].forEach({self.contentView.addSubview($0)})
        [descriptionTitle, descriptionBody].forEach({verticalStackView.addSubview($0)})
        
        iconImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(20.0)
            make.leading.equalTo(contentView).offset(15)
//            make.centerY.equalTo(contentView)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(20.0)
            make.leading.equalTo(iconImageView.snp.trailing).offset(15)
//            make.centerY.equalTo(contentView)
        }
        
        infoButton.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(20.0)
            make.trailing.equalTo(contentView).offset(-15)
//            make.centerY.equalTo(contentView)
        }
        
        infoButton.addTarget(self, action: #selector(infoButtonTapped), for: .touchUpInside)
    
        verticalStackView.snp.makeConstraints({ make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20.0)
            make.leading.equalTo(contentView).offset(15.0)
            make.trailing.equalTo(contentView).offset(-15.0)
        })
        
        descriptionTitle.snp.makeConstraints({ make in
            make.top.leading.equalToSuperview().offset(10.0)
        })
       
        descriptionBody.snp.makeConstraints({ make in
            make.top.equalTo(descriptionTitle.snp.bottom).offset(5.0)
            make.leading.equalTo(descriptionTitle.snp.leading)
            make.bottom.equalToSuperview().offset(-10.0)
        })
        
        borderline.snp.makeConstraints({ make in
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-1.0)
            make.leading.equalTo(self.contentView.snp.leading).offset(15.0)
            make.trailing.equalTo(self.contentView.snp.trailing).offset(-15.0)
        })
    }
    
    @objc private func infoButtonTapped() {
        onInfoButtonTapped?(infoButton)
    }
    
    func animateExpansion(isExpanded: Bool) {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.verticalStackView.isHidden = !isExpanded
            self.layoutIfNeeded()
        }, completion: nil)
    }
    

    func configure(with title: String, icon: UIImage?, isExpanded: Bool) {
        titleLabel.text = title
        iconImageView.image = icon
        verticalStackView.isHidden = !isExpanded // 확장 상태에 따라 표시/숨김
        
        if titleLabel.text == "" {
            infoButton.isHidden = true
        }else{
            infoButton.isHidden = false
        }
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
