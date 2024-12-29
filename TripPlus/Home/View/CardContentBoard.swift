//
//  CardContentBoard.swift
//  TripPlus
//
//  Created by 유대상 on 12/25/24.
//

import Foundation
import UIKit
import SnapKit


class CardContentBoard: UIView{
    init() {
        super.init(frame: .zero)
    }
    
    lazy var commonTitle: CommonTitle = {
        let view = CommonTitle()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var cardContentCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
//        layout.itemSize = CGSize(width: self.frame.width, height: 45.0)
//        layout.minimumLineSpacing = 20.0
//        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collectionView.backgroundColor = UIColor(named: "grayA")
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: CardCollectionViewCell.identifier)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        return collectionView
    }()
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        [commonTitle, cardContentCollectionView].forEach({self.addSubview($0)})
        
        commonTitle.snp.makeConstraints({ make in
            make.top.equalToSuperview().offset(20.0)
            make.leading.equalToSuperview().offset(15.0)
        })
        
        if let layout = cardContentCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = CGSize(width: (self.frame.width / 3), height: 200.0)
            layout.minimumLineSpacing = 15.0
        }
        
        cardContentCollectionView.snp.makeConstraints({ make in
            make.top.equalTo(commonTitle.snp.bottom).offset(10.0)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(200.0)
        })
        
    }
    
    func configureTitle(title: String, headline: String){
        commonTitle.configure(title: title, header: headline)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
