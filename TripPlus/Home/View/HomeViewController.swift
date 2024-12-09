//
//  ViewController.swift
//  TripPlus
//
//  Created by 유대상 on 8/18/24.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {

    private lazy var scrollView: UIScrollView = {
        let scrView = UIScrollView()
        scrView.bouncesHorizontally = false
        scrView.translatesAutoresizingMaskIntoConstraints = false
        scrView.showsVerticalScrollIndicator = false
        return scrView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var logoLabel: UILabel = {
        let label = UILabel()
        label.text = "Trip+"
        label.font = UIFont(name: "PRETENDARD-SemiBold", size: 34)
        label.textColor = UIColor(named: "grayD")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var mainProgressbar: UIProgressView = {
        let view = UIProgressView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var mainProgressbarLabel: UILabel = {
        let label = UILabel()
        label.text = "1/6"
        label.font = UIFont(name: "PRETENDARD-Light", size: 12)
        label.textColor = UIColor(named: "grayD")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var mainCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .lightGray
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: "MainCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }()

    private lazy var myProgressBox: MyTripProgressBox = {
        let box = MyTripProgressBox()
        box.translatesAutoresizingMaskIntoConstraints = false
        return box
    }()
    
    private lazy var myTripSuppliesBoard: MyTripSuppliesBoard = {
        let board = MyTripSuppliesBoard()
        board.translatesAutoresizingMaskIntoConstraints = false
        return board
    }()
    
    private lazy var myTripTipBoard: MyTripTipBoard = {
        let board = MyTripTipBoard()
        board.translatesAutoresizingMaskIntoConstraints = false
        return board
    }()
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setViews()
    }

    private func setViews(){
        //ScrollView 때문에, 모듈화 한 View들의 Height을 명시해줘야 할 수도 있음
        //logoLabel -> NavigationBar Title로 사용 될 수도.

        self.view.addSubview(scrollView)
        self.view.addSubview(logoLabel)
        
        scrollView.addSubview(contentView)
        
        [mainCollectionView, mainProgressbar, mainProgressbarLabel,
         myProgressBox, myTripSuppliesBoard, myTripTipBoard
        ].forEach({ self.contentView.addSubview($0) })
        
        logoLabel.snp.makeConstraints({ make in
            make.top.equalTo(self.view.safeAreaInsets.top)
            make.leading.equalToSuperview().inset(15.0)
        })
        
        scrollView.snp.makeConstraints({ make in
            make.edges.equalToSuperview()
        })
        
        contentView.snp.makeConstraints({ make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
            make.height.equalTo(1600.0)
        })
        
        mainCollectionView.snp.makeConstraints({ make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(480.0)
        })

        mainProgressbar.snp.makeConstraints({ make in
            make.bottom.equalTo(mainCollectionView.snp.bottom).offset(-17.0)
            make.centerX.equalToSuperview()
            make.height.equalTo(20.0)
        })
        
        mainProgressbarLabel.snp.makeConstraints({ make in
            make.leading.equalTo(mainProgressbar.snp.trailing).offset(8.0)
            make.bottom.equalTo(mainCollectionView.snp.bottom).offset(-17.0)
        })
        
        myProgressBox.snp.makeConstraints({ make in
            make.top.equalTo(mainCollectionView.snp.bottom).offset(20.0)
            make.leading.equalToSuperview().offset(15.0)
            make.trailing.equalToSuperview().offset(-15.0)
        })
        
        myTripSuppliesBoard.snp.makeConstraints({ make in
            make.top.equalTo(myProgressBox.snp.bottom)
            make.leading.trailing.equalToSuperview()
        })
        
        수정 필요
        myTripTipBoard.snp.makeConstraints({ make in
            make.top.equalTo(myTripSuppliesBoard.snp.bottom).offset(150.0)
            make.leading.trailing.equalToSuperview()
        })
        
//        myProgressBox.configure(dday: <#T##String#>, percent: <#T##Int#>, destination: <#T##String#>)
//        myTripSuppliesBoard.configure(suppliesList: <#T##[String]#>)
//        myTripTipBoard.configure(username: <#T##String#>, destination: <#T##String#>, description: <#T##String#>)
    }

}






extension HomeViewController : UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier, for: indexPath) as? MainCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(title: "A", description: "B", writtenBy: "C")
        
        return cell
    }
    
    
}


