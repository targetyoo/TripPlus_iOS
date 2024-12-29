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
        scrView.contentInsetAdjustmentBehavior = .never //SafeArea나 NavigationBar 등
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
        layout.itemSize = CGSize(width: self.view.frame.width, height: 480.0)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .lightGray
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: MainCollectionViewCell.identifier)
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
    
    private lazy var rankingBoard: RankingBoard = {
        let rankView = RankingBoard()
        rankView.rankingCollectionView.delegate = self
        rankView.rankingCollectionView.dataSource = self
        return rankView
    }()
    
    private lazy var listContentBoard: ListContentBoard = {
        let view = ListContentBoard()
        view.listContentCollectionView.delegate = self
        view.listContentCollectionView.dataSource = self
        return view
    }()
    
    private lazy var cardContentBoard: CardContentBoard = {
        let view = CardContentBoard()
        view.cardContentCollectionView.delegate = self
        view.cardContentCollectionView.dataSource = self
        return view
    }()
    

    
    private lazy var thirdCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .lightGray
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "DefaultCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    private lazy var infoBox: InfoBox = {
        let view = InfoBox()
        view.snp.makeConstraints({ make in
            make.height.equalTo(280.0)
        })
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
         myProgressBox, myTripSuppliesBoard, myTripTipBoard,
         rankingBoard, cardContentBoard, listContentBoard,
         infoBox
        ].forEach({ self.contentView.addSubview($0) })
        
        logoLabel.snp.makeConstraints({ make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview().inset(15.0)
        })
        
        scrollView.snp.makeConstraints({ make in
            make.edges.equalToSuperview()
        })
        
        contentView.snp.makeConstraints({ make in
            make.top.equalToSuperview()
            make.leading.trailing.bottom.equalToSuperview()
            make.width.equalTo(scrollView.frameLayoutGuide)
            make.height.equalTo(3000.0)
        })
        
        mainCollectionView.snp.makeConstraints({ make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(480.0)
        })

        mainProgressbar.snp.makeConstraints({ make in
//            make.bottom.equalTo(mainCollectionView.snp.bottom).offset(-17.0)
            make.centerY.equalTo(mainProgressbarLabel.snp.centerY)
            make.centerX.equalToSuperview()
            make.width.equalTo(112.0)
        })
        
        mainProgressbarLabel.snp.makeConstraints({ make in
            make.leading.equalTo(mainProgressbar.snp.trailing).offset(8.0)
            make.bottom.equalTo(mainCollectionView.snp.bottom).offset(-10.0)
        })
        
        myProgressBox.snp.makeConstraints({ make in
            make.top.equalTo(mainCollectionView.snp.bottom).offset(10.0)
            make.leading.trailing.equalToSuperview()
        })
        
        myTripSuppliesBoard.snp.makeConstraints({ make in
            make.top.equalTo(myProgressBox.snp.bottom).offset(10.0)
            make.leading.trailing.equalToSuperview()
        })
        
        myTripTipBoard.snp.makeConstraints({ make in
            make.top.equalTo(myTripSuppliesBoard.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview()
        })

        rankingBoard.snp.makeConstraints({ make in
            make.top.equalTo(myTripTipBoard.snp.bottom).offset(40.0)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(430.0)
        })
        
        listContentBoard.snp.makeConstraints({ make in
            make.top.equalTo(rankingBoard.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(635.0)
        })
        
        cardContentBoard.snp.makeConstraints({ make in
            make.top.equalTo(listContentBoard.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(300.0)
        })
        
        infoBox.snp.makeConstraints({ make in
            make.top.equalTo(cardContentBoard.snp.bottom).offset(25.0)
            make.leading.trailing.equalToSuperview()
        })

//        아래 부터 수정 필요
//        / 아래 collectionView 추가. 근데 데이터가 오는 시점에 분기를 탄다고 한다. 그냥 CollectionView를 깡통으로 만들어놓고, 어떤 함수에 유동적으로 파라미터에 따라 cell register가 가능한지를 확인해보자.
        
        /*
         enum class CONTENT_TYPE{
             DEPARTURE, // 출국자 수
             TIP, // 팁
             LIST, // 리스트 형태
             RANK // 랭킹 형태
         }
         */
        

        
//        myProgressBox.configure(dday: <#T##String#>, percent: <#T##Int#>, destination: <#T##String#>)
//        myTripSuppliesBoard.configure(suppliesList: <#T##[String]#>)
        myTripTipBoard.configure(description: "Too many nights in a row, you're getting tired")
    }
    
    

}






extension HomeViewController : UICollectionViewDataSource, UICollectionViewDelegate{
    
    //    func configureHomeCollectionView(with type: ContentType) {
    //        switch type {
    //        case .departure:
    //            firstCollectionView.register(DepartureCell.self,
    //                forCellWithReuseIdentifier: DepartureCell.identifier)
    //        case .tip:
    //            firstCollectionView.register(TipCell.self,
    //                forCellWithReuseIdentifier: TipCell.identifier)
    //        case .list:
    //            firstCollectionView.register(ListCell.self,
    //                forCellWithReuseIdentifier: ListCell.identifier)
    //        case .rank:
    //            firstCollectionView.register(RankCell.self,
    //                forCellWithReuseIdentifier: RankCell.identifier)
    //        }
    //
    //        firstCollectionView.reloadData()
    //    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = UICollectionViewCell()
        
        if collectionView == mainCollectionView{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier, for: indexPath) as? MainCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            cell.configure(title: "Title", description: "description", writtenBy: "wittenBy")
            
            return cell
            
        }else if collectionView == rankingBoard.rankingCollectionView{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RankingCell.identifier, for: indexPath) as? RankingCell else {
                return UICollectionViewCell()
            }
            
            cell.configure(index: 0, imgURL: "", NationCity: "대한민국 서울")
            
            return cell
            
        }else if collectionView == cardContentBoard.cardContentCollectionView{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCollectionViewCell.identifier, for: indexPath) as? CardCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configure(thumbnail: "", thumbnailName: "구로구")
            return cell
            
        }else if collectionView == listContentBoard.listContentCollectionView{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCollectionViewCell.identifier, for: indexPath) as? ListCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configure(index: 99, title: "물갈비는 맵다", location: "백년갈비", body: "맵지만 맛있는 물갈비 먹고싶다 진짜진짜 맵지만 맛있는 물갈비 먹고싶다 진짜진짜 맵지만 맛있는 물갈비 먹고싶다 진짜진짜 맵지만 맛있는 물갈비 먹고싶다 진짜진짜 맵지만 맛있는 물갈비 먹고싶다 진짜진짜 맵지만 맛있는 물갈비 먹고싶다 진짜진짜 맵지만 맛있는 물갈비 먹고싶다 진짜진짜 맵지만 맛있는 물갈비 먹고싶다 진짜진짜 맵지만 맛있는 물갈비 먹고싶다 진짜진짜", thumbnailImage: UIImage(), picCount: "+\(3)")
            return cell
        }
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        if collectionView == cardContentBoard.cardContentCollectionView{
//            return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15) // 왼쪽과 오른쪽에 간격 추가
//        }
//        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//
//    }

}




extension HomeViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarTransparent()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        restoreNavigationBar()
    }
    
    private func setNavigationBarTransparent() {
        if #available(iOS 15.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        } else {
            navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationController?.navigationBar.shadowImage = UIImage()
            navigationController?.navigationBar.isTranslucent = true
        }
    }

    private func restoreNavigationBar() {
        if #available(iOS 15.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithDefaultBackground()
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        } else {
            navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
            navigationController?.navigationBar.shadowImage = nil
        }
    }
}
