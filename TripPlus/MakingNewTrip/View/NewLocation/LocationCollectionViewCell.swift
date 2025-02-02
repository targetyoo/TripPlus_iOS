//
//  LocationCollectionViewCell.swift
//  TripPlus
//
//  Created by 유대상 on 1/18/25.
//

import Foundation
import UIKit
import SnapKit

class LocationCollectionViewCell: UICollectionViewCell{
    static let identifier = "LocationCollectionViewCell"
    
    private lazy var cityNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "PRETENDARD-Regular", size: 16.0)
        label.textColor = UIColor(named: "grayA")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var nationNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "PRETENDARD-Light", size: 12.0)
        label.textColor = UIColor(named: "grayB")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [cityNameLabel, nationNameLabel])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var selectBtn: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "checkCircle"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var cellBoarder: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "grayB")
        view.snp.makeConstraints({ make in
            make.height.equalTo(1.0)
        })
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
    }
    
    private func setViews() {
        [verticalStackView, selectBtn, cellBoarder].forEach({self.addSubview($0)})
        
        verticalStackView.snp.makeConstraints({ make in
            make.leading.equalToSuperview().offset(15.0)
            make.centerY.equalToSuperview()
        })
        
        selectBtn.snp.makeConstraints({ make in
            make.trailing.equalToSuperview().offset(-15.0)
            make.centerY.equalToSuperview()
        })
        
        cellBoarder.snp.makeConstraints({ make in
            make.top.equalTo(self.snp.bottom)
            make.leading.trailing.equalToSuperview()
        })
    }
    
    func configure(city: String, nation: String) {
        cityNameLabel.text = city
        nationNameLabel.text = nation
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cityNameLabel.text = ""
        nationNameLabel.text = ""
        selectBtn.setImage(UIImage(named: "checkCircle"), for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
