//
//  LockViewController.swift
//  AppLock
//
//  Created by Ipman on 22/05/2024.
//

import UIKit

class LockViewController: BaseViewController {
    
    @IBOutlet var roundView: [RoundView]!
    @IBOutlet weak var lbMessage: UILabel!
    @IBOutlet weak var lbTitle: UILabel!
    var currentPass: String? = nil
    var pass: String = ""
    var numberWrong: Int = 0
    let maxAttempts = 3
    var lockoutEndTime: Date?
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lbTitle.text = "enter_current_passcode".localized
        currentPass = getPassword()
        lbMessage.text = ""
        restoreLockoutState()
        updateLockTimer()
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
        if isLockout() {
            print("Nhập sai 3 lần, không cho phép thực hiện")
            return
        }
        if pass.count < 6{
            pass.append(button.tag.description)
            roundView[pass.count - 1].isActive = true
            lbMessage.text = ""
            guard pass.count == 6 else { return }
            guard let currentPass = currentPass else { return }
            if pass.elementsEqual(currentPass){
                self.numberWrong = 0
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                    self.navigationController?.popViewController(animated: true)
                }
                
            }else{
                
                
                self.clearPasscode {
                    self.numberWrong += 1
                    if self.numberWrong >= self.maxAttempts{
                        self.lockoutEndTime = Date().addingTimeInterval(182) //chặn 3 phút
                        self.startLockoutTimer()
                        self.saveLockoutState()
                    }else{
                        self.lbMessage.text = "wrong_password".localized
                    }
                }
            }
        }
        
        
    }
    
    @IBAction func tappedToDelete(_ sender: UIButton){
        guard !isLockout() else { return }
        if !pass.isEmpty{
            pass.removeLast()
            roundView[pass.count].isActive = false
        }
    }
    
    func isLockout() -> Bool{
        guard let endTime = lockoutEndTime else { return false }
        if Date() < endTime{
            return true
        }else{
            lockoutEndTime = nil
            saveLockoutState()
            return false
        }
    }
    
    func startLockoutTimer(){
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateLockTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateLockTimer(){
        if isLockout(){
            let remainingTime = Int(lockoutEndTime?.timeIntervalSinceNow ?? 0)
            let minutes = remainingTime / 60
            let seconds = remainingTime % 60
            let message = "message_lock_app".localized
            lbMessage.text = "\(message) \n\(String(format: "%02d:%02d", minutes, seconds))"
            print("Locked out for \(String(format: "%02d:%02d", minutes, seconds))")
        }else{
            timer?.invalidate()
            lbMessage.text = ""
            numberWrong = 0
        }
    }
    
    func saveLockoutState() {
        let userDefaults = UserDefaults.standard
        userDefaults.set(numberWrong, forKey: "incorrectAttempts")
        userDefaults.set(lockoutEndTime, forKey: "lockoutEndTime")
    }
    
    func restoreLockoutState() {
        let userDefaults = UserDefaults.standard
        numberWrong = userDefaults.integer(forKey: "incorrectAttempts")
        lockoutEndTime = userDefaults.object(forKey: "lockoutEndTime") as? Date
        if isLockout() {
            startLockoutTimer()
        }
    }
    
    func getPassword() -> String?{
        let userDefaults = UserDefaults.standard
        return userDefaults.string(forKey: "passwordApp")
    }

}
