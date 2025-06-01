//
//  AddNewPackageViewController.swift
//  TripPlus
//
//  Created by 유대상 on 5/30/25.
//

import Foundation
import UIKit
import SnapKit


class AddNewPackageViewController: UIViewController {
    
    private lazy var viewControllerTitle: UILabel = {
        let label = UILabel()
        label.text = "새로운 준비물"
        label.snp.makeConstraints({make in
            make.height.equalTo(45.0)
        })
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setTitle("취소", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.snp.makeConstraints({make in
            make.height.equalTo(45.0)
        })
//        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    private lazy var confirmButton: UIButton = {
        let button = UIButton()
        button.setTitle("확인", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.snp.makeConstraints({make in
            make.height.equalTo(45.0)
        })
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    private lazy var newPackageBox: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 7.0
//        view.backgroundColor = UIColor(named: "grayD")
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var newPackageIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "pencil")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var newPackageNameView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 7.0
//        view.backgroundColor = UIColor(named: "grayD")
        view.backgroundColor = .systemGray6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var newPackageName: UITextField = {
        let textField = UITextField()
        textField.placeholder = "준비물 이름"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var colorPalete: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 40.0, height: 40.0)
        
        layout.minimumLineSpacing = 20.0 // 셀 간 세로 간격
        layout.minimumInteritemSpacing = 20.0 // 셀 간 가로 간격
        layout.sectionInset = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0) // 섹션 여백
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(PaleteCollectionViewCell.self, forCellWithReuseIdentifier: PaleteCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white
        collectionView.layer.cornerRadius = 7.0
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var iconPalete: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 40.0, height: 40.0)
        
        layout.minimumLineSpacing = 20.0 // 셀 간 세로 간격
        layout.minimumInteritemSpacing = 20.0 // 셀 간 가로 간격
        layout.sectionInset = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0) // 섹션 여백
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(PaleteCollectionViewCell.self, forCellWithReuseIdentifier: PaleteCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white
        collectionView.layer.cornerRadius = 7.0
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setViews()
        self.configureSheetPresentation()
    }

    private func setViews() {
        self.view.backgroundColor = .lightGray
        
        
        [viewControllerTitle, backButton, confirmButton, newPackageBox, colorPalete, iconPalete].forEach({self.view.addSubview($0)})
        
        [newPackageIcon, newPackageNameView].forEach({self.newPackageBox.addSubview($0)})
        
        newPackageNameView.addSubview(newPackageName)
        
        viewControllerTitle.snp.makeConstraints({ make in
            make.top.equalToSuperview().offset(25.0)
            make.centerX.equalToSuperview()
        })
        
        backButton.snp.makeConstraints({ make in
            make.top.equalTo(viewControllerTitle.snp.top)
            make.leading.equalToSuperview().offset(15.0)
        })
        
        confirmButton.snp.makeConstraints({ make in
            make.top.equalTo(viewControllerTitle.snp.top)
            make.trailing.equalToSuperview().offset(-15.0)
        })
        
        newPackageBox.snp.makeConstraints({ make in
            make.top.equalTo(viewControllerTitle.snp.bottom).offset(10.0)
            make.leading.equalToSuperview().offset(15.0)
            make.trailing.equalToSuperview().offset(-15.0)
            make.height.equalTo(125.0)
        })
        
        newPackageIcon.snp.makeConstraints({ make in
            make.top.equalToSuperview().offset(10.0)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(36.0)
        })
        
        newPackageNameView.snp.makeConstraints({ make in
            make.top.equalTo(newPackageIcon.snp.bottom).offset(20.0)
            make.leading.equalToSuperview().offset(10.0)
            make.trailing.equalToSuperview().offset(-10.0)
            make.height.equalTo(45.0)
        })
        
        newPackageName.snp.makeConstraints({ make in
            make.centerX.centerY.equalToSuperview()
        })
        
        colorPalete.snp.makeConstraints({ make in
            make.top.equalTo(newPackageBox.snp.bottom).offset(15.0)
            make.leading.equalToSuperview().offset(15.0)
            make.trailing.equalToSuperview().offset(-15.0)
            make.height.equalTo(120.0)
        })
          
        iconPalete.snp.makeConstraints({ make in
            make.top.equalTo(colorPalete.snp.bottom).offset(15.0)
            make.leading.equalToSuperview().offset(15.0)
            make.trailing.equalToSuperview().offset(-15.0)
            make.height.equalTo(120.0)
        })
                                        
        
    }
    
    private func configureSheetPresentation() {
        // 바텀 시트 설정
        if let sheet = sheetPresentationController {
            // 바텀 시트 크기 설정 (medium, large 등)
            sheet.detents = [.custom { context in
                return context.maximumDetentValue * 0.7 // 화면 높이의 30%
            }, .large()]            // 드래그 가능한 상단 바 표시
            sheet.prefersGrabberVisible = true
            // 모달 뒤의 뷰 흐림 효과
            sheet.prefersEdgeAttachedInCompactHeight = true
            // 바텀 시트가 화면 전체를 덮지 않도록 설정
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
        }
    }
}

extension AddNewPackageViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PaleteCollectionViewCell.identifier, for: indexPath) as? PaleteCollectionViewCell else { return UICollectionViewCell() }
        
        if collectionView == colorPalete{
            cell.configure(paleteColor: .systemBlue, paleteIcon: nil, isIconPalete: false)
        }else{
            cell.configure(paleteColor: nil, paleteIcon: UIImage(systemName: "cloud"), isIconPalete: true)
        }
        return cell
    }
    
}
