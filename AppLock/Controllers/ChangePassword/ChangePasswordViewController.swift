//
//  ChangePasswordViewController.swift
//  AppLock
//
//  Created by Ipman on 23/05/2024.
//

import UIKit
enum ChangePasswordStep{
    case old
    case new
    case confirm
}
protocol ChangePasswordDelegate: AnyObject{
    func configPasswordSuccess()
}
class ChangePasswordViewController: UIViewController {
    @IBOutlet var roundView: [RoundView]!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbMessage: UILabel!
    var currentPass: String? = nil
    var pass: String = ""
    var newPass: String = ""
    var confirmPass: String = ""
    var currStep: ChangePasswordStep = .old
    var firstConfig = false
    weak var delegate: ChangePasswordDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        currentPass = getPassword()
        
        self.lbTitle.text = currStep == .old ? "enter_current_passcode".localized : "enter_new_passcode".localized
        firstConfig = currStep == .new
        lbMessage.text = ""
    }
    
    func clearPasscode(completion: @escaping () -> Void){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){ [weak self] in
            guard let self = self else { return }
            self.pass = ""
            self.roundView.enumerated().forEach { index, view in
                view.isActive = false
            }
            completion()
        }
    }
    
    @IBAction func tappedToButtonNumber(_ button: UIButton){
        if pass.count < 6{
            pass.append(button.tag.description)
            roundView[pass.count - 1].isActive = true
            lbMessage.text = ""
            guard pass.count == 6 else { return }
            switch currStep {
            case .old:
                hanlderOldPassword()
            case .new:
                newPassword()
            case .confirm:
                confirmPassword()
            }
        }
    }
    
    func hanlderOldPassword(){
        guard let currentPass = currentPass else { return }
        if pass.elementsEqual(currentPass){
            // next step input new password
            self.clearPasscode{
                self.lbTitle.text = "enter_new_passcode".localized
            }
            
            currStep = .new
        }else{
            
            self.lbMessage.text = "wrong_password".localized
            self.clearPasscode{}
            
        }
    }
    
    func newPassword(){
        
        newPass = pass
        self.clearPasscode{
            self.lbTitle.text = "enter_confirm_passcode".localized
        }
        currStep = .confirm
    }
    
    func confirmPassword(){
        if pass == newPass{
            //confirm success
            currentPass = pass
            self.lbMessage.text = "message_change_passcode_success".localized
            self.lbMessage.textColor = .systemGreen
            saveNewPassword()
            //save new pass
            DispatchQueue.main.asyncAfter(deadline: .now() + 1){ [weak self] in
                guard let self = self else { return }
                if let delelgate = self.delegate, self.firstConfig{
                    self.savePasswordEnable(status: true)
                    delelgate.configPasswordSuccess()
                }
                self.dismiss(animated: true)
            }
            
        }else{
            // confrim failed
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){ [weak self] in
                guard let self = self else { return }
                self.clearPasscode{
                    self.lbMessage.text = "messsage_confirm_passcode_faild".localized
                }
            }
        }
    }
    
    func saveNewPassword(){
        let userDefaults = UserDefaults.standard
        userDefaults.set(currentPass, forKey: "passwordApp")
    }
    
    func savePasswordEnable(status: Bool){
        let userDefaults = UserDefaults.standard
        userDefaults.set(status, forKey: "isPasswordEnable")
    }
    
    func getPassword() -> String?{
        let userDefaults = UserDefaults.standard
        return userDefaults.string(forKey: "passwordApp")
    }
    
    @IBAction func tappedToDelete(_ sender: UIButton){
        if !pass.isEmpty{
            pass.removeLast()
            roundView[pass.count].isActive = false
        }
    }
}
