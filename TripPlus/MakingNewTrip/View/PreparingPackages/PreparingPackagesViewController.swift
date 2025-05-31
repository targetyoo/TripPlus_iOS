//
//  PreparingPackagesViewController.swift
//  TripPlus
//
//  Created by 유대상 on 5/29/25.
//

import Foundation
import SnapKit
import UIKit


class PreparingPackagesViewController: UIViewController {

//    private lazy var contentView: UIView = {
//        let view = UIView()
//        view.backgroundColor = UIColor(named: "tripGreen")
//        view.backgroundColor = UIColor(cgColor: CGColor(red: 68/255, green: 112/255, blue: 84/255, alpha: 1)) //Temp
//        return view
//    }()
    
    private lazy var creatringPackIcon: UIImageView = {
       let view = UIImageView()
        view.image = UIImage(systemName: "location.fill")
        if #available(iOS 17.0, *) {
            view.addSymbolEffect(.bounce, options: .repeating, animated: true, completion: nil)
        }
        view.tintColor = UIColor(named: "grayD")
        view.tintColor = .white //Temp
        view.contentMode = .scaleAspectFit
        view.snp.makeConstraints({make in
            make.height.equalTo(48)
        })
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var creatringPack_DescriptionTitle: UILabel = {
       let label = UILabel()
        label.text = "준비물 생성 중..."
        label.textColor = UIColor(named: "grayD")
        label.textColor = .white //Temp
        label.font = UIFont(name: "PRETENDARD-Semibold", size: 24.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var creatringPack_DescriptionBody: UILabel = {
        let label = UILabel()
        label.text = "입력해주신 여행 정보를 바탕으로\n준비물을 챙기고 있어요."
        label.textColor = UIColor(named: "grayD")
        label.textColor = .white //Temp
        label.font = UIFont(name: "PRETENDARD-Medium", size: 20.0)
        label.numberOfLines = 0
        //줄간격 추가하기
        label.translatesAutoresizingMaskIntoConstraints = false
         return label
    }()
    
    private lazy var descriptionVerticalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [creatringPack_DescriptionTitle, creatringPack_DescriptionBody])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .equalCentering
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [creatringPackIcon, descriptionVerticalStackView])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .equalCentering
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let style = UIImpactFeedbackGenerator.FeedbackStyle.light // medium, heavy, rigid, soft
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.prepare()
        generator.impactOccurred()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            //로드 완료 후 화면 이동
//            let swiftUIView = CreatingPackagesContentView()
//            let hostingController = UIHostingController(rootView: swiftUIView)
//            self.navigationController?.pushViewController(hostingController, animated: true)
            print("yo~")
            let settingPackagesVC = SettingPackagesViewController()
            self.navigationController?.pushViewController(settingPackagesVC, animated: true)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(named: "tripGreen")
        self.view.backgroundColor = UIColor(cgColor: CGColor(red: 68/255, green: 112/255, blue: 84/255, alpha: 1)) //Temp
        setViews()
    }

    
    private func setViews(){
//        self.view.addSubview(contentView)
        
//        contentView.snp.makeConstraints({ make in
//            make.edges.equalToSuperview()
//        })
        
        [verticalStackView].forEach({self.view.addSubview($0)})
        
        verticalStackView.snp.makeConstraints({ make in
            make.centerX.centerY.equalToSuperview()
        })
    }
    
   
    

}

