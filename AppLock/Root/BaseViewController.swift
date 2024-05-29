//
//  BaseViewController.swift
//  AppLock
//
//  Created by Ipman on 23/05/2024.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        updateLocalizedStrings()
        NotificationCenter.default.addObserver(self, selector: #selector(updateLocalizedStrings), name: .languageChange, object: nil)
    }
    
    @objc func updateLocalizedStrings(){
        print("update localized")
    }
    
    deinit{
        NotificationCenter.default.removeObserver(self, name: .languageChange, object: nil)
    }
    
    
}
