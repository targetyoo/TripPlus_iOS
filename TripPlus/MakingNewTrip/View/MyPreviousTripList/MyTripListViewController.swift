//
//  MyTripListViewController.swift
//  TripPlus
//
//  Created by 유대상 on 1/3/25.
//

import Foundation
import UIKit
import SnapKit
import Combine

class MyTripListViewController: UIViewController {
    
    private var cancellables = Set<AnyCancellable>()

    private lazy var myTripEmptyView: MyTripEmptyView = {
        let view = MyTripEmptyView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViews()
    }
    
    
    private func setViews() {
        
        self.view.addSubview(myTripEmptyView)
        
        myTripEmptyView.snp.makeConstraints({ make in
            make.top.equalToSuperview().offset((self.view.frame.height - self.view.safeAreaInsets.top - self.view.safeAreaInsets.bottom) / 3.0)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(95.0)
        })
        
        myTripEmptyView.makeTripBtn.isUserInteractionEnabled = true
//        myTripEmptyView.makeTripBtn.controlPublisher(for: UIControl.Event.touchUpInside)
//            .sink { [weak self] _ in
//                self?.myTripEmptyView.makeTripBtn.isHidden = true
//            }
//            .store(in: &cancellables)
        
        myTripEmptyView.makeTripBtn.publisher(for: .touchUpInside)
             .sink { [weak self] _ in
                 let makingNewTripVC = MakingNewTripViewController()
                 
                 // 필요한 데이터 전달 (예: tripName)
                 makingNewTripVC.tripName = "새로운 여행" // tripName 변수를 설정
                 
                 
//                 let backBarButtonItem = UIBarButtonItem(title: "이전", style: .plain, target: self, action: nil)
//                 self?.navigationItem.backBarButtonItem = backBarButtonItem
                 
                 let backAttributes = [NSAttributedString.Key.font: UIFont(name: "PRETENDARD-Regular", size: 16)]
                 let titleAttributes = [NSAttributedString.Key.font: UIFont(name: "PRETENDARD-SemiBold", size: 16)]

//                 self?.navigationItem.backBarButtonItem?.setTitleTextAttributes(backAttributes as [NSAttributedString.Key : Any], for: .normal)
                 self?.navigationController?.navigationBar.titleTextAttributes = titleAttributes as [NSAttributedString.Key : Any]

                 // 현재 ViewController에서 새로운 ViewController로 이동
                 self?.navigationController?.pushViewController(makingNewTripVC, animated: true)

             }
             .store(in: &cancellables)
    }
    
}
