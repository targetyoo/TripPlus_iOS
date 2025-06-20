//
//  MyTripPageViewModel.swift
//  TripPlus
//
//  Created by andev on 6/14/25.
//

import Foundation
import UIKit

class MyTripPageViewModel {
       
    var tempCompanion = ["유재석", "박명수", "정준하", "노홍철", "하동훈", "전진", "길성준"]
    
    var tableTempData: [PackageCellData] = [
        PackageCellData(title: "보조 배터리", icon: UIImage(systemName: "battery.100"), description: "언제 어디서 조난당할지 몰라요. \n여분의 전력은 선택이 아닌 필수입니다"),
        PackageCellData(title: "워터슈즈", icon: UIImage(systemName: "shoe.fill"), description: "연중 강수량이 높은 지역입니다. \n비싼 신발 들고가면 후회할지도 몰라요", isChecked: true),
        PackageCellData(title: "007 가방", icon: UIImage(systemName: "shoe.fill"), description: "가방을 통째로 도둑맞아도 전혀 걱정없는 가방 \n호신용으로도 사용할 수 있습니다"),
        PackageCellData(title: "물티슈", icon: UIImage(systemName: "shoe.fill"), description: "야시장에서 이것저것 먹을 때, 무더운날 아이스크림을 먹을 때, 핑거푸드 먹을 때", isChecked: true),
        PackageCellData(title: "감성 업그레이드 에세이", icon: UIImage(systemName: "shoe.fill"), description: "공항에서 비는 시간, 이 책 한권과 함께라면 나도 감성적인 여행자")
    ]
}
