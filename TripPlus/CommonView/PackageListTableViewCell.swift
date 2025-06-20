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
    
    var onInfoButtonTapped: (() -> Void)?
    //    var onInfoButtonTapped: ((UIButton) -> Void)?
    var onCheckButtonTapped: (() -> Void)?
    
    var isExpanded: Bool = false{
        didSet {
            self.animateExpansion(isExpanded: isExpanded)
        }
    }
    
    private let iconImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.tintColor = UIColor(named: "grayA")
        imgView.snp.makeConstraints({ make in
            make.width.height.equalTo(24)
        })
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = UIColor(named: "grayA")
        label.lineBreakMode = .byTruncatingTail
        label.snp.makeConstraints({ make in
            make.height.equalTo(24)
        })
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let infoButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "infoIcon"), for: .normal)
        btn.tintColor = UIColor(named: "grayB")
        btn.snp.makeConstraints({ make in
            make.width.height.equalTo(24)
        })
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var checkButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "checkCircle"), for: .normal)
        btn.tintColor = UIColor(named: "grayB")
        btn.snp.makeConstraints({ make in
            make.width.height.equalTo(24)
        })
        btn.translatesAutoresizingMaskIntoConstraints = false
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
        [iconImageView, titleLabel, infoButton, checkButton, borderline, verticalStackView].forEach({self.contentView.addSubview($0)})
        [descriptionTitle, descriptionBody].forEach({verticalStackView.addSubview($0)})
        
        checkButton.snp.makeConstraints({ make in
            make.top.equalTo(contentView.snp.top).offset(20.0)
            make.leading.equalToSuperview().offset(15.0)
        })
        checkButton.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
        
        iconImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(20.0)
            make.leading.equalTo(checkButton.snp.trailing).offset(15)
            //            make.centerY.equalTo(contentView)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(20.0)
            make.leading.equalTo(iconImageView.snp.trailing).offset(15)
            make.trailing.equalTo(infoButton.snp.leading).offset(-15)
        }
        
        infoButton.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(20.0)
            make.trailing.equalTo(contentView).offset(-15)
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
        onInfoButtonTapped?()
    }
    
    @objc private func checkButtonTapped() {
        onCheckButtonTapped?()
    }
    
    func animateExpansion(isExpanded: Bool) {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.verticalStackView.isHidden = !isExpanded
            self.layoutIfNeeded()
        }, completion: nil)
    }
    
    
    //    func configure(with title: String, icon: UIImage?, isExpanded: Bool, description: String) {
    func configure(with title: String, icon: UIImage?, isExpanded: Bool, description: String, needChecking: Bool = false) {
        titleLabel.text = title
        iconImageView.image = icon
        self.isExpanded = isExpanded // 확장 상태에 따라 표시/숨김
        
        if title == "" {
            infoButton.isHidden = true
        }else{
            infoButton.isHidden = false
        }
        
        if description == ""{
            infoButton.isHidden = true
        }else{
            infoButton.isHidden = false
        }
        
        if needChecking{
            checkButton.isHidden = false
        }else{
            if title == ""{
                //TODO: UI가 부자연스러움. 회의 시 안건
            }else{
                //TODO: 수정소요 더 발생 시, configure 함수 분리 예정
                iconImageView.snp.removeConstraints()
                iconImageView.snp.makeConstraints({ make in
                    make.top.equalTo(contentView.snp.top).offset(20.0)
                    make.leading.equalTo(contentView.snp.leading).offset(15)
                    make.width.height.equalTo(24)
                })
                
                titleLabel.snp.makeConstraints { make in
                    make.leading.equalTo(iconImageView.snp.trailing).offset(15)
                }
            }
            checkButton.isHidden = true
        }
    }
    
    func isChecked(checked: Bool){
        if checked{
            checkButton.tintColor = UIColor(named: "tripGreen")
            checkButton.setImage(UIImage(named: "checkCircle_checked"), for: .normal)
        }else{
            checkButton.tintColor = UIColor(named: "grayB")
            checkButton.setImage(UIImage(named: "checkCircle"), for: .normal)
        }
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
