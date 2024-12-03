//
//  ViewController.swift
//  TripPlus
//
//  Created by 유대상 on 8/18/24.
//

import UIKit

class HomeViewController: UIViewController {

    private lazy var scrollView: UIScrollView = {
        let scrView = UIScrollView()
        scrView.bouncesHorizontally = false
        scrView.translatesAutoresizingMaskIntoConstraints = false
        return scrView
    }()
    
    private lazy var logoLabel: UILabel = {
        let label = UILabel()
        label.text = "Trip+"
        label.font = UIFont(name: "PRETENDARD-SemiBold", size: 34)
        label.textColor = UIColor(named: "grayD")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
<<<<<<< HEAD
    
    
<<<<<<< HEAD
    private lazy var getReadyBox: UIView = {
        let view = UIView()
=======
<<<<<<< HEAD
    private lazy var getReadyBox: UIView = {
        let view = UIView()
=======
    private lazy var mainProgressbar: UIProgressView = {
        let view = UIProgressView()
>>>>>>> 3ee07a3 ([UI] 홈 화면 일부 구현)
>>>>>>> 4438042 ([UI] 홈 화면 일부 구현)
=======
    private lazy var mainProgressbar: UIProgressView = {
        let view = UIProgressView()
>>>>>>> f8ce86e (git error fixing)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
<<<<<<< HEAD
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
>>>>>>> 3ee07a3 ([UI] 홈 화면 일부 구현)
>>>>>>> 4438042 ([UI] 홈 화면 일부 구현)
    
=======
 
>>>>>>> f8ce86e (git error fixing)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setViews()
    }

    private func setViews(){
        
    }

}









