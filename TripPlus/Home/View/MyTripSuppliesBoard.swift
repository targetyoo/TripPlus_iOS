//
//  MyTripProgressBoard.swift
//  TripPlus
//
//  Created by 유대상 on 11/28/24.
//

import Foundation
import UIKit

class MyTripSuppliesBoard : UIView{
    //실 데이터 사용 시, 주석문을 해제하여 사용
    
//    init(data: YourDataModel) {
    init() {
        super.init(frame: .zero)
//        setupView(with: data)
        setupView()
        self.layer.cornerRadius = 14
        self.backgroundColor = UIColor(named: "grayD")
    }
    
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 4438042 ([UI] 홈 화면 일부 구현)
    private lazy var : = {
        .translatesAutoresizingMaskIntoConstraints = false
        return
    }()
    private lazy var : = {
        .translatesAutoresizingMaskIntoConstraints = false
        return
    }()
<<<<<<< HEAD
=======
=======
    private lazy var inadequateSuppliesHeader: UILabel = {
         let label = UILabel()
         label.textColor = UIColor(named: "grayA")
         label.font = UIFont(name: "PRETENDARD-SemiBold", size: 24)
         label.numberOfLines = 0
         label.translatesAutoresizingMaskIntoConstraints = false
         label.text = "아직 여권이 준비되지 않았어요"
         return label
     }()
     
     private lazy var inadequateSuppliesHeader2: UILabel = {
         let label = UILabel()
         label.textColor = UIColor(named: "grayA")
         label.font = UIFont(name: "PRETENDARD-Regular", size: 16)
         label.numberOfLines = 0
         label.translatesAutoresizingMaskIntoConstraints = false
         label.text = "여권은 넉넉하게 한 달 전에 준비하는 걸 추천드려요"
         return label
     }()
     
     
     
     private lazy var inadequateSuppliesBox: UIView = {
         let view = UIView()
         view.layer.cornerRadius = 14
         view.backgroundColor = UIColor(named: "grayC")
         view.translatesAutoresizingMaskIntoConstraints = false
         return view
     }()
     
     private lazy var inadequateSuppliesBoxHeader: UILabel = {
         let label = UILabel()
         label.textColor = UIColor(named: "grayA")
         label.font = UIFont(name: "PRETENDARD-Regular", size: 16)
         label.numberOfLines = 0
         label.translatesAutoresizingMaskIntoConstraints = false
         label.text = "여권은 넉넉하게 한 달 전에 준비하는 걸 추천드려요"
         return label
     }()
     
     private lazy var inadequateSuppliesBoxButton: UIButton = {
         let btn = UIButton()
         btn.setTitle("전체 준비물", for: .normal)
         btn.titleLabel?.font = UIFont(name: "PRETENDARD-Light", size: 12)
         btn.setTitleColor(UIColor(named: "grayB"), for: .normal)

         let chevronImage = UIImage(named: "arrow_to_right")
         btn.setImage(chevronImage, for: .normal)
         btn.imageView?.tintColor = UIColor(named: "grayB")
         btn.imageView?.contentMode = .scaleAspectFit
          
          // 이미지와 타이틀 간격 및 정렬
         btn.semanticContentAttribute = .forceRightToLeft
         btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: -10)
          
          // 제약 조건
 //        btn.snp.makeConstraints { make in
 //             make.height.equalTo(44) // 최소 터치 영역
 //        }
         btn.backgroundColor = UIColor(.clear)
         btn.translatesAutoresizingMaskIntoConstraints = false
         return btn
     }()
     
     
     
     private lazy var inadequateSuppliesBox_ItemIcon1: UIImageView = {
         let imgView = UIImageView()
         imgView.tintColor = UIColor(named: "tripGreen")
         imgView.translatesAutoresizingMaskIntoConstraints = false
         return imgView
     }()
     
     private lazy var inadequateSuppliesBox_ItemName1: UILabel = {
         let label = UILabel()
         label.textColor = UIColor(named: "grayA")
         label.font = UIFont(name: "PRETENDARD-Regular", size: 16)
         label.numberOfLines = 0
         label.translatesAutoresizingMaskIntoConstraints = false
         label.text = "아이템1"
         return label
     }()
     
     private lazy var inadequateSuppliesBox_ItemIcon2: UIImageView = {
         let imgView = UIImageView()
         imgView.tintColor = UIColor(named: "tripGreen")
         imgView.translatesAutoresizingMaskIntoConstraints = false
         return imgView
     }()
     
     private lazy var inadequateSuppliesBox_ItemName2: UILabel = {
         let label = UILabel()
         label.textColor = UIColor(named: "grayA")
         label.font = UIFont(name: "PRETENDARD-Regular", size: 16)
         label.numberOfLines = 0
         label.translatesAutoresizingMaskIntoConstraints = false
         label.text = "아이템2"
         return label
     }()
     
     private lazy var inadequateSuppliesBox_ItemIcon3: UIImageView = {
         let imgView = UIImageView()
         imgView.tintColor = UIColor(named: "tripGreen")
         imgView.translatesAutoresizingMaskIntoConstraints = false
         return imgView
     }()
     
     private lazy var inadequateSuppliesBox_ItemName3: UILabel = {
         let label = UILabel()
         label.textColor = UIColor(named: "grayA")
         label.font = UIFont(name: "PRETENDARD-Regular", size: 16)
         label.numberOfLines = 0
         label.translatesAutoresizingMaskIntoConstraints = false
         label.text = "아이템3"
         return label
     }()
     
     private lazy var inadequateSuppliesBox_ItemIcon4: UIImageView = {
         let imgView = UIImageView()
         imgView.tintColor = UIColor(named: "tripGreen")
         imgView.translatesAutoresizingMaskIntoConstraints = false
         return imgView
     }()
     
     private lazy var inadequateSuppliesBox_ItemName4: UILabel = {
         let label = UILabel()
         label.textColor = UIColor(named: "grayA")
         label.font = UIFont(name: "PRETENDARD-Regular", size: 16)
         label.numberOfLines = 0
         label.translatesAutoresizingMaskIntoConstraints = false
         label.text = "아이템4"
         return label
     }()

>>>>>>> 3ee07a3 ([UI] 홈 화면 일부 구현)
>>>>>>> 4438042 ([UI] 홈 화면 일부 구현)
    
//    private func setupView(with data: YourDataModel) {
    private func setupView() {
        // 서브뷰 생성 및 레이아웃 설정
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
        
        [inadequateSuppliesHeader, inadequateSuppliesHeader2,
         inadequateSuppliesBox,
         inadequateSuppliesBoxHeader, inadequateSuppliesBoxButton,
         inadequateSuppliesBox_ItemIcon1, inadequateSuppliesBox_ItemName1,
         inadequateSuppliesBox_ItemIcon2, inadequateSuppliesBox_ItemName2,
         inadequateSuppliesBox_ItemIcon3, inadequateSuppliesBox_ItemName3,
         inadequateSuppliesBox_ItemIcon4, inadequateSuppliesBox_ItemName4 ].forEach({
            self.addSubview($0)
        })

        
        
        
        
>>>>>>> 3ee07a3 ([UI] 홈 화면 일부 구현)
>>>>>>> 4438042 ([UI] 홈 화면 일부 구현)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
