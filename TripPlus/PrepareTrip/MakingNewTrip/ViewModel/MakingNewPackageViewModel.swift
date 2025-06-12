//
//  MakingNewPackageViewModel.swift
//  TripPlus
//
//  Created by 유대상 on 5/31/25.
//

import Foundation
import UIKit
import Combine

class MakingNewPackageViewModel {
    
    @Published var packageList: [PackageCellData] = [
        PackageCellData(title: "보조 배터리", icon: UIImage(systemName: "battery.100"), description: "언제 어디서 조난당할지 몰라요. \n여분의 전력은 선택이 아닌 필수입니다", isExpanded: false),
        PackageCellData(title: "워터슈즈", icon: UIImage(systemName: "shoe.fill"), description: "연중 강수량이 높은 지역입니다. \n비싼 신발 들고가면 후회할지도 몰라요", isExpanded: false),
        PackageCellData(title: "007 가방", icon: UIImage(systemName: "shoe.fill"), description: "가방을 통째로 도둑맞아도 전혀 걱정없는 가방 \n호신용으로도 사용할 수 있습니다", isExpanded: false),
        PackageCellData(title: "물티슈", icon: UIImage(systemName: "shoe.fill"), description: "야시장에서 이것저것 먹을 때, 무더운날 아이스크림을 먹을 때, 핑거푸드 먹을 때", isExpanded: false),
        PackageCellData(title: "감성 업그레이드 에세이", icon: UIImage(systemName: "shoe.fill"), description: "공항에서 비는 시간, 이 책 한권과 함께라면 나도 감성적인 여행자", isExpanded: false)
    ] //TEMP Data


    @Published var packageName: String = ""
    @Published var packageIcon: UIImage = PaleteIconData.icons[0]!
    @Published var packageColor: UIColor = PaleteColorData.colors[0]!

    
    var preparingPackageFinished: AnyPublisher<[PackageCellData], Never> {
        return preparingPackageSubject.eraseToAnyPublisher()
    }
    
    var textViewEditingChanged: AnyPublisher<String, Never> {
        return textViewEditingChangedSubject.eraseToAnyPublisher()
    }
    
    var iconTabbed: AnyPublisher<UIImage, Never> {
        return packageIconSubject.eraseToAnyPublisher()
    }
    
    var colorTabbed: AnyPublisher<UIColor, Never> {
        return packageColorSubject.eraseToAnyPublisher()
    }
    

    let preparingPackageSubject = PassthroughSubject<[PackageCellData], Never>()
    private let textViewEditingChangedSubject = PassthroughSubject<String, Never>()
    private let packageIconSubject = PassthroughSubject<UIImage, Never>()
    private let packageColorSubject = PassthroughSubject<UIColor, Never>()


    
    func preparingPackage(completion: @escaping () -> Void) {
        //TODO: API 통신 후 send(준비물 Array 전달)
        print("1")
        print("찍고싶은만큼찍을건데?")
        print("1")

            self.preparingPackageSubject.send(self.packageList)
        completion()
    }
    
    
    func writingTitle(_ text: String) {
        textViewEditingChangedSubject.send(text)
        if packageName.count <= 15 {
            packageName = text
            print(packageName)
        }
    }
    
    func selectPackageIcon(_ icon: UIImage){
        packageIconSubject.send(icon)
        packageIcon = icon
    }
    
    func selectPackageColor(_ color: UIColor){
        packageColorSubject.send(color)
        packageColor = color
    }
}
