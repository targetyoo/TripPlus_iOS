//
//  PackageCellData.swift
//  TripPlus
//
//  Created by 유대상 on 5/31/25.
//

import Foundation
import UIKit

struct PackageCellData {
    var title: String
    var icon: UIImage?
    var tintColor: UIColor?
    //    var hasDescription: Bool //사용자가 추가한 준비물에는 description이 존재하지 않음
    var description: String = ""
    var isChecked: Bool = false // 체크 상태
//    var isExpanded: Bool = false // 확장 상태
    var bottomSheetTitle: String = ""
    var bottomSheetText: String = ""
    var bottomSheetSemiTitle: String = ""
    var bottomSheetDescription: String = ""

}
