//
//  MyTripPackageListViewController.swift
//  TripPlus
//
//  Created by 유대상 on 5/31/25.
//

import Foundation
import UIKit
import SnapKit

class MyTripPackageListViewController: UIViewController{
    
    private let pageViewControllers: [UIViewController] = [MyTripPackageViewController(), MyTripPackageViewController()]
    let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    var index: Int = 0
    
    private lazy var previousBtn : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "arrow_right"), for: .normal)
        btn.snp.makeConstraints({ make in
            make.width.height.equalTo(24.0)
        })
        btn.tintColor = UIColor(named: "grayA")
        btn.addTarget(self, action: #selector(previousBtnTapped), for: .touchDown)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var nextBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "arrow_left"), for: .normal)
        btn.snp.makeConstraints({ make in
            make.width.height.equalTo(24.0)
        })
        btn.tintColor = UIColor(named: "grayA")
        btn.addTarget(self, action: #selector(nextBtnTapped), for: .touchDown)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var tripTitle: UILabel = {
        let label = UILabel()
        label.text = "Trip Title"
        label.textColor = UIColor(named: "grayA")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        setChildVC()
    }
    
    private func setViews() {
        [tripTitle, previousBtn, nextBtn, containerView].forEach({ view.addSubview($0) })
        
        tripTitle.snp.makeConstraints({ make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        })
        
        previousBtn.snp.makeConstraints({ make in
            make.top.equalTo(tripTitle.snp.top)
            make.leading.equalToSuperview().offset(15.0)
        })
        
        nextBtn.snp.makeConstraints({ make in
            make.top.equalTo(tripTitle.snp.top)
            make.trailing.equalToSuperview().offset(-15.0)
        })
        
        containerView.snp.makeConstraints({ make in
            make.top.equalTo(tripTitle.snp.bottom).offset(20.0)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        })
    }
    
    
    private func setChildVC(){
        pageViewController.setViewControllers([pageViewControllers[0]],
                                              direction: .forward,
                                              animated: true,
                                              completion: nil)

        for pageViewController in pageViewControllers{
            let tpVC = pageViewController as! MyTripPackageViewController
            tpVC.setTestValues(testValue: 0)
        }
        
        addChild(pageViewController)
        containerView.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        pageViewController.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc private func previousBtnTapped(){
        if index > 0{
            index = index - 1
            pageViewController.setViewControllers([pageViewControllers[index]], direction: .reverse, animated: true, completion: nil)
        }
        print(index)
    }
    
    @objc private func nextBtnTapped(){
        if index < pageViewControllers.count - 1 {
            index = index + 1
            pageViewController.setViewControllers([pageViewControllers[index]], direction: .forward, animated: true, completion: nil)
        }
        print(index)
    }
}





// MARK: - UIPageViewControllerDataSource
extension MyTripPackageListViewController: UIPageViewControllerDataSource {
    
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
extension MyTripPackageListViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController,
                          didFinishAnimating finished: Bool,
                          previousViewControllers: [UIViewController],
                          transitionCompleted completed: Bool) {
        // 페이지 전환 완료 시 추가 작업이 필요한 경우 여기에 구현
    }
}
