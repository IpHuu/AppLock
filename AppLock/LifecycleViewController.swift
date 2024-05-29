//
//  LifecycleViewController.swift
//  AppLock
//
//  Created by Ipman on 24/05/2024.
//

import UIKit

class LifecycleViewController: UIViewController {
    @IBOutlet weak var sceneDidEnterBackgroundLabel: UILabel!
    @IBOutlet weak var sceneWillEnterForegroundLabel: UILabel!
    @IBOutlet weak var sceneWillResignActiveLabel: UILabel!
    @IBOutlet weak var sceneDidBecomeActiveLabel: UILabel!
    @IBOutlet weak var willConnectToLabel: UILabel!
    @IBOutlet weak var configurationForConnectingLabel: UILabel!
    @IBOutlet weak var didFinishLaunchingLabel: UILabel!
        
    var sceneDidEnterBackgroundCount = 0
    var sceneWillEnterForegroundCount = 0
    var sceneWillResignActiveCount = 0
    var sceneDidBecomeActiveCount = 0
    var willConnectToCount = 0
    
    var appDelegate = (UIApplication.shared.delegate as! AppDelegate)
    
    func updateView(){
        didFinishLaunchingLabel.text = "The APP has launched \(appDelegate.launchCount) time(s)"
        configurationForConnectingLabel.text = "The APP has connected \(appDelegate.configurationForConnectingCount) time(s)"
        
        willConnectToLabel.text = "The scene will connect \(willConnectToCount) time(s)"
        sceneDidBecomeActiveLabel.text = "The scene did become active \(sceneDidBecomeActiveCount) time(s)"
        sceneWillResignActiveLabel.text = "The scene will resign active \(sceneWillResignActiveCount) time(s)"
        sceneWillEnterForegroundLabel.text = "The scene will enter foreground \(sceneWillEnterForegroundCount) time(s)"
        sceneDidEnterBackgroundLabel.text = "The scene did enter background \(sceneDidEnterBackgroundCount) time(s)"
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
