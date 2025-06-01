//
//  MyTripPageViewController.swift
//  TripPlus
//
//  Created by 유대상 on 5/31/25.
//

import Foundation
import UIKit
import SnapKit
import Combine


class MyTripPageViewController: UIViewController {
    
    private var cancellables = Set<AnyCancellable>()
    
    //사용자의 여행 목록이 한 개도 없을 경우 ====================================
    private lazy var myTripEmptyView: MyTripEmptyView = {
        let view = MyTripEmptyView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    //=================================================================
    
    // 페이지로 사용할 뷰 컨트롤러 배열
    private let pageViewControllers: [UIViewController] = [MyTripPackageListViewController(), MyTripListViewController()]
    
    let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)

    //segment font
    let normalAttributes: [NSAttributedString.Key: Any] = [
        .font: UIFont.systemFont(ofSize: 16, weight: .regular),
        .foregroundColor: UIColor.black
    ]
    let selectedAttributes: [NSAttributedString.Key: Any] = [
        .font: UIFont.systemFont(ofSize: 16, weight: .bold),
        .foregroundColor: UIColor.black
    ]
 
    private lazy var pageSegmentedControl: CustomSegment = {
        let segment = CustomSegment(items: ["준비물", "여행 목록"])
        segment.selectedSegmentIndex = 0
        segment.addTarget(self, action: #selector(handleSegmentChange(_:)), for: .valueChanged)
        
        let image = UIImage()
        segment.setBackgroundImage(image, for: .normal, barMetrics: .default)
        segment.setBackgroundImage(image, for: .selected, barMetrics: .default)
        segment.setBackgroundImage(image, for: .highlighted, barMetrics: .default)
        segment.setDividerImage(image, forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
        segment.setTitleTextAttributes(normalAttributes, for: .normal)
        segment.setTitleTextAttributes(selectedAttributes, for: .selected)
        segment.translatesAutoresizingMaskIntoConstraints = false
        return segment
    }()
    
    private lazy var pageContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var floatingBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "plus"), for: .normal)
        btn.snp.makeConstraints({ make in
            make.width.height.equalTo(55.0)
        })
        btn.tintColor = .white
        btn.backgroundColor = UIColor(named: "tripGreen")
        btn.layer.cornerRadius = btn.bounds.width / 2
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOpacity = 0.3
        btn.layer.shadowOffset = CGSize(width: 0, height: 3)
        btn.layer.shadowRadius = 4
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        setChildVC()
    }
    
    
    private func setViews(){
        self.view.backgroundColor = .white
        
        [myTripEmptyView, pageSegmentedControl, pageContentView, floatingBtn].forEach({self.view.addSubview($0)})
        
        myTripEmptyView.snp.makeConstraints({ make in
            make.top.equalToSuperview().offset((self.view.frame.height - self.view.safeAreaInsets.top - self.view.safeAreaInsets.bottom) / 3.0)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(95.0)
        })
        
        pageSegmentedControl.snp.makeConstraints({ make in
//            make.top.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(50.0)
        })
        
        pageContentView.snp.makeConstraints({ make in
            make.top.equalTo(pageSegmentedControl.snp.bottom).offset(20.0)
            make.leading.trailing.bottom.equalToSuperview()
        })
        pageViewController.dataSource = self
        
        floatingBtn.snp.makeConstraints({ make in
            make.trailing.equalToSuperview().offset(-30.0)
//            make.bottom.equalToSuperview().offset(-30.0)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-30.0)
        })
        
        floatingBtn.publisher(for: .touchUpInside)
             .sink { [weak self] _ in
                 let makingNewTripVC = MakingNewTripViewController()
                 
                 // 필요한 데이터 전달 (예: tripName)
                 makingNewTripVC.tripName = "새로운 여행" // tripName 변수를 설정

                 // 현재 ViewController에서 새로운 ViewController로 이동
                 makingNewTripVC.modalPresentationStyle = .fullScreen
                 self?.navigationController?.setNavigationBarHidden(false, animated: true)
                 self?.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
                 self?.navigationController?.pushViewController(makingNewTripVC, animated: true)

             }
             .store(in: &cancellables)
        
        //TODO: 여행 데이터가 없다면..
//        if 나의여행데이터.isEmpty{
        [pageSegmentedControl, pageContentView].forEach({$0.isHidden = true})
        [myTripEmptyView].forEach({$0.isHidden = false})
//        }else{
//        [pageSegmentedControl, pageContentView].forEach({$0.isHidden = false})
//        [myTripEmptyView].forEach({$0.isHidden = true})
//        }
    }
    
    private func setChildVC(){
        pageViewController.setViewControllers([pageViewControllers[0]],
                                              direction: .forward,
                                              animated: true,
                                              completion: nil)
        
//        // UIPageViewController 스와이프 비활성화
        for subview in pageViewController.view.subviews {
            if let scrollView = subview as? UIScrollView {
                scrollView.isScrollEnabled = false
            }
        }
        
        addChild(pageViewController)
        pageContentView.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        
        pageViewController.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        floatingBtn.layer.cornerRadius = floatingBtn.bounds.width / 2
    }
    
    @objc func handleSegmentChange(_ sender: UISegmentedControl){
        let index = sender.selectedSegmentIndex
        if index == 0{
            pageViewController.setViewControllers([pageViewControllers[index]], direction: .reverse, animated: true, completion: nil)
        }else{
            pageViewController.setViewControllers([pageViewControllers[index]], direction: .forward, animated: true, completion: nil)
        }
    }
    
}

// MARK: - UIPageViewControllerDataSource
extension MyTripPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController,
                          viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pageViewControllers.firstIndex(of: viewController) else { return nil }
        
        let previousIndex = currentIndex - 1
        return previousIndex >= 0 ? pageViewControllers[previousIndex] : nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                          viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pageViewControllers.firstIndex(of: viewController) else { return nil }
        
        let nextIndex = currentIndex + 1
        return nextIndex < pageViewControllers.count ? pageViewControllers[nextIndex] : nil
    }
    
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = pageViewController.viewControllers?.first,
              let firstViewControllerIndex = pageViewControllers.firstIndex(of: firstViewController) else {
            return 0
        }
        return firstViewControllerIndex
    }
}


// MARK: - UIPageViewControllerDelegate
extension MyTripPageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController,
                          didFinishAnimating finished: Bool,
                          previousViewControllers: [UIViewController],
                          transitionCompleted completed: Bool) {
        // 페이지 전환 완료 시 추가 작업이 필요한 경우 여기에 구현
    }
}
