//
//  MyTripProgressBoard.swift
//  TripPlus
//
//  Created by 유대상 on 11/28/24.
//

import Foundation
import UIKit
import SnapKit

class MyTripSuppliesBoard : UIView {
    //실 데이터 사용 시, 주석문을 해제하여 사용
    
//    init(data: YourDataModel) {
    init() {
        super.init(frame: .zero)
//        setupView(with: data)
        setupViews()
//        self.layer.cornerRadius = 14
//        self.backgroundColor = UIColor(named: "grayD")
    }
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [commonTitle, inadequateSuppliesBox])
        view.axis = .vertical
        view.spacing = 10
        view.distribution = .fill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var commonTitle: CommonTitle = {
        let view = CommonTitle()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

     private lazy var inadequateSuppliesBox: UIView = {
         let view = UIView()
         view.layer.cornerRadius = 14
         view.backgroundColor = UIColor(named: "grayC")
         view.snp.makeConstraints { make in
             make.height.equalTo(155)
         }
         view.translatesAutoresizingMaskIntoConstraints = false
         return view
     }()
     
     private lazy var inadequateSuppliesBoxHeader: UILabel = {
         let label = UILabel()
         label.textColor = UIColor(named: "grayA")
         label.font = UIFont(name: "PRETENDARD-Medium", size: 20)
         label.numberOfLines = 0
         label.translatesAutoresizingMaskIntoConstraints = false
         label.text = "아직 못챙긴 준비물"
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
         btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -15)
          
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
         imgView.image = UIImage(named: "checkCircle_checked")
         imgView.snp.makeConstraints { make in
             make.height.width.equalTo(24)
         }
         imgView.translatesAutoresizingMaskIntoConstraints = false
         return imgView
     }()
     
     private lazy var inadequateSuppliesBox_ItemName1: UILabel = {
         let label = UILabel()
         label.textColor = UIColor(named: "grayA")
         label.font = UIFont(name: "PRETENDARD-Regular", size: 16)
         label.numberOfLines = 0
         label.snp.makeConstraints { make in
             make.height.equalTo(24)
         }
         label.translatesAutoresizingMaskIntoConstraints = false
         label.text = "아이템1"
         return label
     }()
     
     private lazy var inadequateSuppliesBox_ItemIcon2: UIImageView = {
         let imgView = UIImageView()
         imgView.tintColor = UIColor(named: "tripGreen")
         imgView.image = UIImage(named: "checkCircle_checked")
         imgView.snp.makeConstraints { make in
             make.height.width.equalTo(24)
         }
         imgView.translatesAutoresizingMaskIntoConstraints = false
         return imgView
     }()
     
     private lazy var inadequateSuppliesBox_ItemName2: UILabel = {
         let label = UILabel()
         label.textColor = UIColor(named: "grayA")
         label.font = UIFont(name: "PRETENDARD-Regular", size: 16)
         label.numberOfLines = 0
         label.snp.makeConstraints { make in
             make.height.equalTo(24)
         }
         label.translatesAutoresizingMaskIntoConstraints = false
         label.text = "아이템2"
         return label
     }()
     
     private lazy var inadequateSuppliesBox_ItemIcon3: UIImageView = {
         let imgView = UIImageView()
         imgView.tintColor = UIColor(named: "tripGreen")
         imgView.image = UIImage(named: "checkCircle_checked")
         imgView.snp.makeConstraints { make in
             make.height.width.equalTo(24)
         }
         imgView.translatesAutoresizingMaskIntoConstraints = false
         return imgView
     }()
     
     private lazy var inadequateSuppliesBox_ItemName3: UILabel = {
         let label = UILabel()
         label.textColor = UIColor(named: "grayA")
         label.font = UIFont(name: "PRETENDARD-Regular", size: 16)
         label.numberOfLines = 0
         label.snp.makeConstraints { make in
             make.height.equalTo(24)
         }
         label.translatesAutoresizingMaskIntoConstraints = false
         label.text = "최첨단 브리타 정수기"
         return label
     }()
     
     private lazy var inadequateSuppliesBox_ItemIcon4: UIImageView = {
         let imgView = UIImageView()
         imgView.tintColor = UIColor(named: "tripGreen")
         imgView.image = UIImage(named: "checkCircle_checked")
         imgView.snp.makeConstraints { make in
             make.height.width.equalTo(24)
         }
         imgView.translatesAutoresizingMaskIntoConstraints = false
         return imgView
     }()
     
     private lazy var inadequateSuppliesBox_ItemName4: UILabel = {
         let label = UILabel()
         label.textColor = UIColor(named: "grayA")
         label.font = UIFont(name: "PRETENDARD-Regular", size: 16)
         label.numberOfLines = 0
         label.snp.makeConstraints { make in
             make.height.equalTo(24)
         }
         label.translatesAutoresizingMaskIntoConstraints = false
         label.text = "아이템4"
         return label
     }()
    
    private lazy var inadequateSuppliesBox_StackView1: UIStackView = {
        let view = UIStackView(arrangedSubviews: [inadequateSuppliesBox_ItemIcon1, inadequateSuppliesBox_ItemName1])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alignment = .fill
        view.axis = .horizontal
        view.spacing = 20.0
        return view
    }()
    
    private lazy var inadequateSuppliesBox_StackView2: UIStackView = {
        let view = UIStackView(arrangedSubviews: [inadequateSuppliesBox_ItemIcon2, inadequateSuppliesBox_ItemName2])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alignment = .fill
        view.axis = .horizontal
        view.spacing = 20.0
        return view
    }()
    
    private lazy var inadequateSuppliesBox_StackView3: UIStackView = {
        let view = UIStackView(arrangedSubviews: [inadequateSuppliesBox_ItemIcon3, inadequateSuppliesBox_ItemName3])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alignment = .fill
        view.axis = .horizontal
        view.spacing = 20.0
        return view
    }()
    
    private lazy var inadequateSuppliesBox_StackView4: UIStackView = {
        let view = UIStackView(arrangedSubviews: [inadequateSuppliesBox_ItemIcon4, inadequateSuppliesBox_ItemName4])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alignment = .fill
        view.axis = .horizontal
        view.spacing = 20.0
        return view
    }()

    
//    private func setupView(with data: YourDataModel) {
    private func setupViews(){
        
        self.addSubview(stackView)
        
        [inadequateSuppliesBoxHeader, inadequateSuppliesBoxButton,
         inadequateSuppliesBox_StackView1, inadequateSuppliesBox_StackView2, inadequateSuppliesBox_StackView3, inadequateSuppliesBox_StackView4
        ].forEach({self.inadequateSuppliesBox.addSubview($0)})
        
        
        stackView.snp.makeConstraints({ make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
        })
        
        //Box 내부
        inadequateSuppliesBoxHeader.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(10)
        }
        
        inadequateSuppliesBoxButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        //TODO: touch 이벤트 추가(inadequateSuppliesBox)
        
        //TODO: 준비물이 4개 미만일 시 StackView를 통째로 가릴 수 있는 메소드
    }

    func configure(suppliesList: [String]){
        //아직 준비물이 뭔지 몰라서 미구현
        //suppliesList를 통해 아이콘과 name을 붙여준다
        print(suppliesList)
    }
    
    func configureTitle(title: String, headline: String){
        commonTitle.configure(title: title, header: headline)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        inadequateSuppliesBox_ItemName1.snp.makeConstraints({ make in
            make.width.equalTo(self.frame.width / 2 - (inadequateSuppliesBox_ItemIcon1.frame.width + 20 + 15 + 25) ) //아이콘과의 간격 + 다음 아이템과의 간격 + Box inset
        })
        
        inadequateSuppliesBox_ItemName2.snp.makeConstraints({ make in
            make.width.equalTo(self.frame.width / 2 - (inadequateSuppliesBox_ItemIcon2.frame.width + 20 + 15 + 25) ) //아이콘과의 간격 + 다음 아이템과의 간격 + Box inset
        })
        
        inadequateSuppliesBox_ItemName3.snp.makeConstraints({ make in
            make.width.equalTo(self.frame.width / 2 - (inadequateSuppliesBox_ItemIcon3.frame.width + 20 + 15 + 25) ) //아이콘과의 간격 + 다음 아이템과의 간격 + Box inset
        })
        
        inadequateSuppliesBox_ItemName4.snp.makeConstraints({ make in
            make.width.equalTo(self.frame.width / 2 - (inadequateSuppliesBox_ItemIcon4.frame.width + 20 + 15 + 25) ) //아이콘과의 간격 + 다음 아이템과의 간격 + Box inset
        })
        
        inadequateSuppliesBox_StackView1.snp.makeConstraints { make in
            make.top.equalTo(inadequateSuppliesBoxHeader.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(10)
        }
        
        inadequateSuppliesBox_StackView2.snp.makeConstraints { make in
            make.top.equalTo(inadequateSuppliesBoxHeader.snp.bottom).offset(20)
            make.leading.equalTo(inadequateSuppliesBox_StackView1.snp.trailing).offset(10)
        }
        
        inadequateSuppliesBox_StackView3.snp.makeConstraints({ make in
            make.top.equalTo(inadequateSuppliesBox_StackView1.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(10)
        })

        inadequateSuppliesBox_StackView4.snp.makeConstraints({ make in
            make.top.equalTo(inadequateSuppliesBox_StackView1.snp.bottom).offset(15)
            make.leading.equalTo(inadequateSuppliesBox_StackView3.snp.trailing).offset(10)
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
