//
//  TabbarViewController.swift
//  AppLock
//
//  Created by Ipman on 22/05/2024.
//

import UIKit

class TabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeVC = UINavigationController(rootViewController: HomeViewController())
        homeVC.tabBarItem.title = "home".localized
        homeVC.tabBarItem.image = UIImage(systemName: "house")
        let settingVC = UINavigationController(rootViewController: SettingViewController())
        settingVC.isNavigationBarHidden = false
        settingVC.tabBarItem.title = "setting".localized
        settingVC.tabBarItem.image = UIImage(systemName: "gearshape.fill")
        self.viewControllers = [homeVC, settingVC]
        self.tabBar.tintColor = .red
        
        if getStatusPasswordEnable() && getPassword() != nil{
            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                [weak self] in
                let vc = LockViewController()
                self?.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
    }
    
    func getStatusPasswordEnable() -> Bool{
        let userDefaults = UserDefaults.standard
        return userDefaults.bool(forKey: "isPasswordEnable")
    }
    
    func getPassword() -> String?{
        let userDefaults = UserDefaults.standard
        return userDefaults.string(forKey: "passwordApp")
    }
    
    
}
