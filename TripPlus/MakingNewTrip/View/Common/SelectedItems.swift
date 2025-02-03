//
//  SelectedItems.swift
//  TripPlus
//
//  Created by 유대상 on 1/28/25.
//

import Foundation
import UIKit
import Combine
import SnapKit

class SelectedItemsView: UIView {
    init() {
        super.init(frame: .zero)
    }
    
    lazy var selectedItemsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0.0, left: 15.0, bottom: 0.0, right: 15.0)
        layout.minimumLineSpacing = 10.0
        layout.minimumInteritemSpacing = 10.0
        layout.estimatedItemSize = .zero
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.alwaysBounceHorizontal = true
        collectionView.register(SelectedItemsCollectionViewCell.self, forCellWithReuseIdentifier: SelectedItemsCollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        [ selectedItemsCollectionView ].forEach({ self.addSubview($0) })

        selectedItemsCollectionView.snp.makeConstraints({ make in
            make.edges.equalToSuperview()
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




class SelectedItemsCollectionViewCell: UICollectionViewCell {
    static let identifier = "SelectedItemsCollectionViewCell"
    private var cancellables = Set<AnyCancellable>()

    private lazy var selectedItemLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "grayD")
        label.font = UIFont(name: "PRETENDARD-Regular", size: 16.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var deleteSelectedItemBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "x"), for: .normal)
        btn.tintColor = UIColor(named: "grayD")
        btn.snp.makeConstraints({ make in
            make.width.height.equalTo(24.0)
        })
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func layoutSubviews() {
        setViews()
    }
    
    private func setViews(){
        [selectedItemLabel, deleteSelectedItemBtn].forEach({self.addSubview($0)})
        
        selectedItemLabel.snp.makeConstraints({ make in
            make.leading.equalToSuperview().offset(5.0)
            make.centerY.equalToSuperview()
        })
         
        deleteSelectedItemBtn.snp.makeConstraints({ make in
            make.trailing.equalToSuperview().offset(-5.0)
            make.centerY.equalToSuperview()
        })
        
        self.layer.cornerRadius = RIGHTALIGHNEDCELL_ITEM_RADIUS
        self.layer.masksToBounds = true
        self.backgroundColor = UIColor(named: "tripGreen")
    }
    
    func configure(itemName: String, onSelect: @escaping (String) -> Void) {
        selectedItemLabel.text = itemName
        
        deleteSelectedItemBtn.publisher(for: .touchUpInside)
            .sink { _ in
                onSelect(itemName)
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


/*
 func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
     let itemName = "Your Item Name" // 실제 데이터에서 가져와야 함
     let font = UIFont.systemFont(ofSize: 16) // 라벨의 폰트 설정
     let textWidth = (itemName as NSString).boundingRect(
         with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: 24.0),
         options: [.usesLineFragmentOrigin, .usesFontLeading],
         attributes: [.font: font],
         context: nil
     ).width
     
     // 여백을 추가하여 셀의 너비를 계산
     let width = textWidth + 30 // 좌우 여백을 고려한 너비 (예: 5 + 24 + 5)
     return CGSize(width: width, height: 24.0)
 }
 */

