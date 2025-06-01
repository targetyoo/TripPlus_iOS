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
        PackageCellData(title: "보조 배터리", icon: UIImage(systemName: "battery.100"), isExpanded: false),
        PackageCellData(title: "워터슈즈", icon: UIImage(systemName: "shoe.fill"), isExpanded: false),
        PackageCellData(title: "007 가방", icon: UIImage(systemName: "shoe.fill"), isExpanded: false),
        PackageCellData(title: "물티슈", icon: UIImage(systemName: "shoe.fill"), isExpanded: false),
        PackageCellData(title: "감성 업그레이드 에세이", icon: UIImage(systemName: "shoe.fill"), isExpanded: false)
    ] //TEMP Data
}
