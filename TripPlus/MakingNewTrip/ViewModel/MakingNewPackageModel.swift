//
//  MakingNewPackageModel.swift
//  TripPlus
//
//  Created by 유대상 on 5/31/25.
//

import Foundation
import UIKit

class MakingNewPackageModel {
    
    @Published var tableTempData: [PackageCellData] = [
        PackageCellData(title: "보조 배터리 1", icon: UIImage(systemName: "battery.100"), isExpanded: false),
        PackageCellData(title: "워터슈즈 1", icon: UIImage(systemName: "shoe.fill"), isExpanded: false),
        PackageCellData(title: "워터슈즈 2", icon: UIImage(systemName: "shoe.fill"), isExpanded: false),
        PackageCellData(title: "워터슈즈 3", icon: UIImage(systemName: "shoe.fill"), isExpanded: false),
        PackageCellData(title: "워터슈즈 4", icon: UIImage(systemName: "shoe.fill"), isExpanded: false)
    ]
}
