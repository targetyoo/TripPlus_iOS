//
//  LocationList.swift
//  TripPlus
//
//  Created by 유대상 on 9/22/24.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class LocationList: UITableView{
    let disposeBag = DisposeBag()
    
//    let hearderView = UIView(
//        frame: CGRect(
//            origin: .zero,
//            size: CGSize(width: UIScreen.main.bounds.width, height: 1.0)
//        )
//    )
    
    //SelectNewLocationViewController -> LocationList
    let cellData = PublishSubject<[LocationListCellData]>()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        bind()
        layout()
        attribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bind(){
        cellData
            .asDriver(onErrorJustReturn: [])
            .drive(self.rx.items) { tableView, row, data in
                let index = IndexPath(row: row, section: 0)
                let cell = tableView.dequeueReusableCell(withIdentifier: "LocationListCell", for: index) as! LocationListCell
                cell.setData(data)
                return cell
            }
            .disposed(by: disposeBag)
    }
    
    private func attribute(){
        self.register(LocationListCell.self, forCellReuseIdentifier: "LocationListCell")
        self.separatorStyle = .singleLine
        self.rowHeight = 80.0
        
        self.backgroundColor = .red

    }
    
    private func layout(){
        
    }
}
