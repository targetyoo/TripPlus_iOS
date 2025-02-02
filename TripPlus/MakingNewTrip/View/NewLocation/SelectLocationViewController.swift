//
//  SelectLocationViewController.swift
//  TripPlus
//
//  Created by 유대상 on 1/18/25.
//

import Foundation
import UIKit
import SnapKit
import Combine

class SelectLocationViewController: UIViewController{
    
    private lazy var searchBar: SearchBarView = {
        let view = SearchBarView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var locationCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: self.view.frame.width, height: 80.0)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 150
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "LocationCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 1)
        view.layer.shadowOpacity = 0.2
        view.layer.shadowRadius = 12
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    private lazy var completeBtn: UIButton = {
       let btn = UIButton()
        btn.layer.cornerRadius = 14.0
        btn.setTitle("완료", for: .normal)
        btn.setTitleColor(UIColor(named: "grayA"), for: .normal)
        btn.titleLabel?.font = UIFont(name: "Pretendard-Regular", size: 16.0)
        btn.backgroundColor = .lightGray
        btn.snp.makeConstraints({ make in
            make.height.equalTo(50.0)
        })
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViews()
        
    }
    
    private func setViews(){
        [searchBar, locationCollectionView, completeBtn].forEach({ self.view.addSubview($0)})
        self.view.bringSubviewToFront(searchBar)
        
        searchBar.snp.makeConstraints({ make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(10.0)
            make.leading.equalToSuperview().offset(15.0)
            make.trailing.equalToSuperview().offset(-15.0)
        })
        
        locationCollectionView.snp.makeConstraints({ make in
            make.top.equalTo(searchBar.snp.bottom)
            make.leading.trailing.equalToSuperview()
        })
        
        completeBtn.snp.makeConstraints({ make in
            make.bottom.equalToSuperview().offset(50.0)
            make.leading.equalToSuperview().offset(15.0)
            make.trailing.equalToSuperview().offset(-15.0)
        })
        
        searchBar.configure(type: .TYPE_DESTINATION)
    }
}


extension SelectLocationViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LocationCollectionViewCell.identifier, for: indexPath) as? LocationCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(city: "라스베가스", nation: "네바다 주, 미국")
        
        return cell
    }
    
    
}
