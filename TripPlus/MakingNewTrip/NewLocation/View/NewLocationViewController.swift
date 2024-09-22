//
//  NewLocationViewController.swift
//  TripPlus
//
//  Created by 유대상 on 9/22/24.
//

import Foundation
import UIKit


class NewLocationViewController: UIViewController{
    
    let searchBar = CustomSearchBar()
    let locationListView = LocationList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        attribute()
        layout()
    }
    
    private func bind(){
//        let tapCity = locationListView.check
    }
    
    private func attribute(){
        
    }
    
    private func layout(){
        [searchBar, locationListView].forEach{view.addSubview($0)}
        
        searchBar.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
                
        locationListView.snp.makeConstraints{
            $0.top.equalTo(searchBar.snp.bottom)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}
                                        
