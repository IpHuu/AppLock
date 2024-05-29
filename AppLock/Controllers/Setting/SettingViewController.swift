//
//  SettingViewController.swift
//  AppLock
//
//  Created by Ipman on 22/05/2024.
//

import UIKit

class SettingViewController: BaseViewController {
    var tableView: UITableView = {
        let tb = UITableView()
        tb.rowHeight = 60
        tb.estimatedRowHeight = 60
        return tb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func updateLocalizedStrings() {
        self.title = "setting".localized
        tableView.reloadData()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    @objc func switchPasswordEnable(_ sender: UISwitch){
        if(sender.isOn){
            print("Switch is On")
        }
        else {
            print("Switch is Off")
        }
        savePasswordEnable(status: sender.isOn)
    }
    
    func savePasswordEnable(status: Bool){
        let userDefaults = UserDefaults.standard
        userDefaults.set(status, forKey: "isPasswordEnable")
    }
    
    func getStatusPasswordEnable() -> Bool{
        let userDefaults = UserDefaults.standard
        return userDefaults.bool(forKey: "isPasswordEnable")
    }
    
    

}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource, ChangePasswordDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getPassword() != nil ? 3 : 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")

        if( !(cell != nil))
        {
            cell = UITableViewCell(style: .value1, reuseIdentifier: "Cell")
        }
        cell?.selectionStyle = .none
        cell!.detailTextLabel?.text = ""
        if indexPath.row == 2{
            cell!.textLabel?.text = "lock_with_password".localized
            cell!.imageView!.image = UIImage(systemName: "lock.fill")
            let switchPassword: UISwitch = {
               let switcher = UISwitch()
                switcher.isOn = getStatusPasswordEnable()
                switcher.addTarget(self, action: #selector(switchPasswordEnable), for: .valueChanged)
                return switcher
            }()
            cell?.accessoryView = switchPassword
            
        }
        
        if indexPath.row == 1{
            cell!.textLabel?.text = getPassword() != nil ? "change_password".localized : "config_password".localized
            cell!.imageView!.image = UIImage(systemName: "lock.rotation.open")
            cell?.accessoryView = UIImageView(image: UIImage(systemName: "chevron.forward"))
        }
        
        if indexPath.row == 0{
            cell!.textLabel?.text = "language".localized
            cell!.imageView!.image = UIImage(systemName: "character.bubble.fill.zh")
            cell?.accessoryView = UIImageView(image: UIImage(systemName: "chevron.forward"))
            switch LanguageManager.shared.getAppLanguage(){
            case .english:
                cell!.detailTextLabel?.text = "en".localized
            case .vietnamese:
                cell!.detailTextLabel?.text = "vi".localized
            case .chinese:
                cell!.detailTextLabel?.text = "cn".localized
            }
            
        }
        
        
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0))
            self.showPopupLanguage(view: cell!.detailTextLabel!, rect: cell!.detailTextLabel!.bounds)
        }
        if indexPath.row == 1{
            let vc = ChangePasswordViewController()
            vc.delegate = self
            vc.currStep = getPassword() != nil ? .old : .new
            self.present(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func getPassword() -> String?{
        let userDefaults = UserDefaults.standard
        return userDefaults.string(forKey: "passwordApp")
    }
    
    func configPasswordSuccess() {
        tableView.reloadData()
    }
    func showPopupLanguage(view: UIView, rect: CGRect){
        let optionMenu = UIAlertController(title: nil, message: "chooseLanguage".localized, preferredStyle: .actionSheet)
        
        let vietnam = UIAlertAction(title: "vi".localized, style: .default){ (action) in
            LanguageManager.shared.changeLanguage(.vietnamese)
            self.tableView.reloadData()
        }
        let english = UIAlertAction(title: "en".localized, style: .default){
            (action) in
            LanguageManager.shared.changeLanguage(.english)
            self.tableView.reloadData()
        }
        
        let chinese = UIAlertAction(title: "cn".localized, style: .default){
            (action) in
            LanguageManager.shared.changeLanguage(.chinese)
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "cancel".localized, style: .cancel)
        
        optionMenu.addAction(vietnam)
        optionMenu.addAction(english)
        optionMenu.addAction(chinese)
        optionMenu.addAction(cancelAction)
        
        if let popoverController = optionMenu.popoverPresentationController {
            popoverController.sourceView = view
              popoverController.sourceRect = rect
            popoverController.permittedArrowDirections = [.any]
        }
        self.present(optionMenu, animated: true, completion: nil)
        
    }
    
}
