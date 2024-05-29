//
//  ViewController.swift
//  AppLock
//
//  Created by Ipman on 20/05/2024.
//

import UIKit
import FamilyControls
import Combine
class ViewController: UIViewController {

    private var viewModel = FamilyActivityViewModel()
    private var subscriptions = Set<AnyCancellable>()
    override func viewDidLoad() {
        super.viewDidLoad()
        let showPickerButton = UIButton(type: .system)
        showPickerButton.setTitle("Show Family Activity Picker", for: .normal)
        showPickerButton.addTarget(self, action: #selector(showPicker), for: .touchUpInside)
        
        self.view.addSubview(showPickerButton)
        showPickerButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            showPickerButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            showPickerButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            showPickerButton.widthAnchor.constraint(equalToConstant: 80),
            showPickerButton.heightAnchor.constraint(equalToConstant: 40)
            
        ])
        
        viewModel.$selection.sink { selection in
            print("Selected categories: \(selection.categories)")
            print("Selected applications: \(selection.applications)")
        }.store(in: &subscriptions)
    }
    
    @objc func showPicker() {
        let pickerViewController = FamilyActivityPickerViewController()
        pickerViewController.modalPresentationStyle = .fullScreen
        present(pickerViewController, animated: true, completion: nil)
    }


}

