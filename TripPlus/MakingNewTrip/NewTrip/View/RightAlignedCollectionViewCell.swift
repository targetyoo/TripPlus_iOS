//
//  RightAlignedCollectionViewCell.swift
//  TripPlus
//
//  Created by 유대상 on 1/19/25.
//

import Foundation
import UIKit
import SnapKit

class RightAlignedCollectionViewCell: UICollectionViewCell{
    static let identifier = "LocationCollectionViewCell"

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "PRETENDARD-Regular", size: 16.0)
        label.textColor = UIColor(named: "grayB")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var deleteBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "x"), for: .normal)
        btn.setTitleColor(UIColor(named: "grayB"), for: .normal)
        btn.snp.makeConstraints({make in
            make.width.height.equalTo(24.0)
        })
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, deleteBtn])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 0
        stackView.layer.cornerRadius = 7.0
        stackView.layer.masksToBounds = true
        stackView.backgroundColor = UIColor(named: "grayC")
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
    }
    
    
    private func setViews(){
        self.addSubview(horizontalStackView)
        
        horizontalStackView.snp.makeConstraints({ make in
            make.edges.equalToSuperview()
        })
    }
    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




viewDidLoad(){
 // Flow Layout 설정
              let layout = RightAlignedFlowLayout()
              layout.minimumLineSpacing = 8
              layout.minimumInteritemSpacing = 8
            layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
         // CollectionView 생성
         collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
         collectionView.backgroundColor = .white
         collectionView.isScrollEnabled = false // 스크롤 비활성화
         collectionView.dataSource = self
         collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
         collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "addButtonCell")
         
         view.addSubview(collectionView)
         
         // Auto Layout 설정
         collectionView.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([
               collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
               collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
               collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
               collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
           ])


}




var collectionView: UICollectionView!
    var items: [String] = ["코타키나발루", "스페인", "독일", "아르헨티나", "마다가스카르", "북한"]
    var collectionViewHeightConstraint: NSLayoutConstraint! // 높이 제약
    
    @objc func addItem() {
        items.append("\(items.count + 1)")
        collectionView.reloadData()
    }
    
    func updateCollectionViewHeight() {
        // 내용물의 높이에 맞게 CollectionView의 높이 업데이트
        collectionView.layoutIfNeeded()
        collectionViewHeightConstraint.constant = collectionView.contentSize.height
    }
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row < items.count {
            // 일반 박스 셀
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            cell.backgroundColor = .systemBlue
            cell.layer.cornerRadius = 8
            
            // UILabel 추가
            for subview in cell.contentView.subviews { subview.removeFromSuperview() }
            let label = UILabel()
            label.text = items[indexPath.row]
            label.textColor = .white
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 16)
            label.numberOfLines = 1
            label.sizeToFit()
            
            cell.contentView.addSubview(label)
            label.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                label.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 10),
                label.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -10),
                label.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 10),
                label.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: -10)
            ])
            
            return cell
        } else {
            // + 버튼 셀
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "addButtonCell", for: indexPath)
            cell.backgroundColor = .systemGray5
            
            for subview in cell.contentView.subviews { subview.removeFromSuperview() }
            let button = UIButton(type: .system)
            button.setTitle("+", for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .bold)
            button.addTarget(self, action: #selector(addItem), for: .touchUpInside)
            
            cell.contentView.addSubview(button)
            button.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                button.centerXAnchor.constraint(equalTo: cell.contentView.centerXAnchor),
                button.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor)
            ])
            
            return cell
        }
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                
        if indexPath.row < items.count {
                // 일반 박스 셀: 텍스트 길이에 맞게 크기 조정
                let text = items[indexPath.row]
                let font = UIFont.systemFont(ofSize: 16)
                
                // 텍스트의 실제 너비 계산
                let textWidth = (text as NSString).boundingRect(
                    with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: 50),
                    options: [.usesLineFragmentOrigin, .usesFontLeading],
                    attributes: [.font: font],
                    context: nil
                ).width
                
                // 여백 추가
                let width = textWidth + 5 // 좌우 여백 20 추가
                return CGSize(width: width, height: 50) // 높이는 고정
            } else {
                // + 버튼 셀: 고정된 크기
                return CGSize(width: 50, height: 50)
            }
    }
