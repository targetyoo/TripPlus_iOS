//
//  MyTripListViewController.swift
//  TripPlus
//
//  Created by 유대상 on 5/31/25.
//

import Foundation
import UIKit
import SnapKit
import Combine

class MyTripListViewController: UIViewController {
    
    private var viewModel = MyTripPageViewModel()
    private var cancellablels = Set<AnyCancellable>()
    
    private lazy var myTripListCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: self.view.bounds.width - 30.0, height: 100.0)
        
        layout.minimumLineSpacing = 12.0 // 셀 간 세로 간격
//        layout.minimumInteritemSpacing = 20.0 // 셀 간 가로 간격
//        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10) // 섹션 여백
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MyTripListCollectionViewCell.self, forCellWithReuseIdentifier: MyTripListCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var textFieldContentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "grayC")
        view.snp.makeConstraints({ make in
            make.height.equalTo(40.0)
        })
        view.layer.cornerRadius = 14.0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var searchbar: UITextField = {
        let txtField = UITextField()
        txtField.placeholder = "여행을 검색해보세요"
        txtField.textColor = UIColor(named: "grayB")
        txtField.isEnabled = true
        txtField.isUserInteractionEnabled = true
        txtField.translatesAutoresizingMaskIntoConstraints = false
        return txtField
    }()
    
    private lazy var searchBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "searchBarIcon"), for: .normal)
        btn.imageView?.tintColor = UIColor(named: "grayB")
        btn.snp.makeConstraints({ make in
            make.width.height.equalTo(24.0)
        })
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
    }
    
    private func setViews() {
        self.view.backgroundColor = .white
        [textFieldContentView, myTripListCollectionView].forEach({ self.view.addSubview($0) })
        [searchbar, searchBtn].forEach({ textFieldContentView.addSubview($0) })
        
        textFieldContentView.snp.makeConstraints({ make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(15.0)
            make.trailing.equalToSuperview().offset(-15.0)
        })
        
        searchbar.snp.makeConstraints({ make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(12.0)
        })
        
        searchBtn.snp.makeConstraints({ make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-12.0)
        })
        
        myTripListCollectionView.snp.makeConstraints({ make in
            make.top.equalTo(textFieldContentView.snp.bottom).offset(12.0)
            make.leading.trailing.bottom.equalToSuperview()
        })
                
    }
    
}



extension MyTripListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //TODO: Data 적용 필요
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyTripListCollectionViewCell.identifier, for: indexPath) as? MyTripListCollectionViewCell else { return UICollectionViewCell() }
        
        cell.onDeleteButtonTapped = { [weak self] in
        }
        
        cell.onCopyLinkButtonTapped = { [weak self] in
            
        }
        cell.onSettingButtonTapped = { [weak self] in
            
        }
        
//        if collectionView == colorPalete{
//            cell.configure(paleteColor: .systemBlue, paleteIcon: nil, isIconPalete: false)
//        }else{
//            cell.configure(paleteColor: nil, paleteIcon: UIImage(systemName: "cloud"), isIconPalete: true)
//        }
        return cell
    }
    
}

