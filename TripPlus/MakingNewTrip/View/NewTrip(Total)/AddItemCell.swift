//
//  AddItemCell.swift
//  TripPlus
//
//  Created by 유대상 on 1/19/25.
//

import Foundation
import UIKit
import SnapKit
import Combine

class AddItemCell: UICollectionViewCell{
    static let identifier = "AddItemCell"
    private var cancellables = Set<AnyCancellable>()

    lazy var addBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "cellPlus"), for: .normal)
        btn.tintColor = UIColor(named: "grayB")
        btn.snp.makeConstraints({make in
            make.width.height.equalTo(DesignSystem.Common.icon_size)
        })
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
    }
    
    private func setViews(){
        self.addSubview(addBtn)
        
        addBtn.snp.makeConstraints({ make in
            make.leading.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
        })
    }
    
    func configure(onSelect: @escaping () -> Void){
        addBtn.publisher(for: .touchUpInside)
            .sink { _ in
                onSelect()
            }
            .store(in: &cancellables)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cancellables.removeAll()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

