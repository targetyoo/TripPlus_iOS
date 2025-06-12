//
//  PaleteCollectionViewCell.swift
//  TripPlus
//
//  Created by 유대상 on 5/30/25.
//

import Foundation
import SnapKit
import UIKit
import Combine


class PaleteCollectionViewCell: UICollectionViewCell {
    static let identifier = "PaleteCollectionViewCell"
    let viewModel = MakingNewPackageViewModel()
    private var cancellables = Set<AnyCancellable>()
    let tapGesture = UITapGestureRecognizer()

    private lazy var paleteView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "grayC")
        view.layer.masksToBounds = true
        view.addGestureRecognizer(tapGesture)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var paleteIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = UIColor(named: "grayA")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private func setup() {
        backgroundColor = .clear
        
        self.contentView.addSubview(paleteView)
        paleteView.addSubview(paleteIcon)
        paleteView.layer.cornerRadius = paleteView.frame.width / 2
        
        paleteView.snp.makeConstraints({make in
            make.height.width.equalTo(40)
            make.edges.equalToSuperview()
        })
        
        paleteIcon.snp.makeConstraints({ make in
            make.height.width.equalTo(24)
            make.centerX.centerY.equalToSuperview()
        })
                
        layoutIfNeeded()
        paleteView.layer.cornerRadius = paleteView.bounds.width / 2
    }
    
    func configure(paleteColor: UIColor?, paleteIcon: UIImage?, isIconPalete: Bool, onSelect: @escaping () -> Void) {
        self.paleteIcon.image = nil
        paleteView.backgroundColor = paleteColor
        
        if isIconPalete {
            self.paleteIcon.image = paleteIcon
            self.paleteView.backgroundColor = UIColor(named: "grayC")
            self.paleteIcon.isHidden = false
        }else{
            self.paleteIcon.isHidden = true
        }
        
        tapGesture.tapPublisher
            .sink { _ in
                onSelect()
            }
            .store(in: &cancellables)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        // 셀 재사용 시 초기화
        paleteIcon.image = nil
        paleteView.backgroundColor = .systemGray6
        paleteIcon.isHidden = true
    }
}
