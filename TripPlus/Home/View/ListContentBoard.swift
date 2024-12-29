//
//  ListContentBoard.swift
//  TripPlus
//
//  Created by 유대상 on 12/25/24.
//

import Foundation
import UIKit
import SnapKit


class ListContentBoard: UIView{
    init() {
        super.init(frame: .zero)
    }
    
    lazy var commonTitle: CommonTitle = {
        let view = CommonTitle()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var listContentCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
//        layout.itemSize = CGSize(width: self.frame.width, height: 45.0)
//        layout.minimumLineSpacing = 20.0
//        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collectionView.backgroundColor = UIColor(named: "grayA")
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ListCollectionViewCell.self, forCellWithReuseIdentifier: ListCollectionViewCell.identifier)
        return collectionView
    }()
    
    private var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "grayC")
        view.snp.makeConstraints({ make in
            make.height.equalTo(1.0)
        })
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var moreBtn: UIButton = {
        let button = UIButton()
        button.setTitle("더보기", for: .normal)
        button.setTitleColor(UIColor(named: "grayA"), for: .normal)
        button.titleLabel?.font = UIFont(name: "PRETENDARD-Light", size: 12.0)
        button.isUserInteractionEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var emptyView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "grayC")
        view.snp.makeConstraints({ make in
            make.height.equalTo(10.0)
        })
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
                
        [commonTitle, listContentCollectionView, lineView, moreBtn, emptyView].forEach({self.addSubview($0)})
        
        commonTitle.snp.makeConstraints({ make in
            make.top.equalToSuperview().offset(20.0)
            make.leading.equalToSuperview().offset(15.0)
        })
        
        if let layout = listContentCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = CGSize(width: self.frame.width, height: 155.0)
            layout.minimumLineSpacing = 0.0
        }
        
        listContentCollectionView.snp.makeConstraints({ make in
            make.top.equalTo(commonTitle.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(155.0 * 3)
        })
        
        lineView.snp.makeConstraints({ make in
            make.leading.equalToSuperview().offset(15.0)
            make.trailing.equalToSuperview().offset(-15.0)
            make.top.equalTo(listContentCollectionView.snp.bottom).offset(20.0)
        })
        
        moreBtn.snp.makeConstraints({ make in
            make.top.equalTo(lineView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(60.0)
        })
        
        emptyView.snp.makeConstraints({ make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(moreBtn.snp.bottom)
        })
        
    }
    
    
    func configureTitle(title: String, headline: String){
        commonTitle.configure(title: title, header: headline)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
