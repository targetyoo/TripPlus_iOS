//
//  MakeNewTripCompleteViewController.swift
//  TripPlus
//
//  Created by andev on 6/8/25.
//

import Foundation
import UIKit

class MakeNewTripCompleteViewController: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
    }
    
    private func setViews(){
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        self.view.backgroundColor = UIColor(named: "grayD")
    }
}
