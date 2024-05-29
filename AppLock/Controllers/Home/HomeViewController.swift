//
//  HomeViewController.swift
//  AppLock
//
//  Created by Ipman on 22/05/2024.
//

import UIKit

class HomeViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
//        self.navigationItem.largeTitleDisplayMode = .always
    }
    
    override func updateLocalizedStrings() {
        self.title = "home".localized
    }
}
