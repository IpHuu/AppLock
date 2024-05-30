//
//  HomeViewController.swift
//  AppLock
//
//  Created by Ipman on 22/05/2024.
//

import UIKit
import FamilyControls
import SwiftUI

class HomeViewController: BaseViewController {

    // MARK: - Properties
    var hostingController: UIHostingController<SwiftUIView>?
    
    private let _center = AuthorizationCenter.shared
    private let _youTubeBlocker = YouTubeBlocker()
    
    private lazy var _contentView: UIHostingController<some View> = {
        let model = BlockingApplicationModel.shared
        let hostingController = UIHostingController(
            rootView: SwiftUIView()
                .environmentObject(model)
        )
        return hostingController
    }()
    
    private let _numberAppSelection: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()

    private let _blockButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Khoá", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .red
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let _releaseButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Huỷ khoá", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let _buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        _requestAuthorization()
        _setup()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        _numberAppSelection.text = "Số lượng ứng dụng đang chọn: " + _youTubeBlocker.getAppSelected().description
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func updateLocalizedStrings() {
        self.title = "home".localized
        _releaseButton.setTitle("unlock_apps".localized, for: .normal)
        _blockButton.setTitle("lock_apps".localized, for: .normal)
    }
}

// MARK: - Setup
extension HomeViewController {
    private func _setup() {
        _addSubviews()
        _setConstraints()
        _addTargets()
    }

    private func _addTargets() {
        _blockButton.addTarget(self, action: #selector(_tappedBlockButton), for: .touchUpInside)
        _releaseButton.addTarget(self, action: #selector(_tappedReleaseButton), for: .touchUpInside)
    }

    private func _addSubviews() {
        _buttonStackView.addArrangedSubview(_blockButton)
        _buttonStackView.addArrangedSubview(_releaseButton)
        view.addSubview(_buttonStackView)
        addChild(_contentView)
        view.addSubview(_contentView.view)
        view.addSubview(_numberAppSelection)
    }

    private func _setConstraints() {

        _contentView.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            _contentView.view.topAnchor.constraint(equalTo: view.topAnchor),
            _contentView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            _contentView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            _contentView.view.bottomAnchor.constraint(equalTo: _blockButton.topAnchor),
            _numberAppSelection.topAnchor.constraint(equalTo: _contentView.view.bottomAnchor, constant: -60),
            _numberAppSelection.heightAnchor.constraint(equalToConstant: 30),
            _numberAppSelection.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
        ])
        
        

        NSLayoutConstraint.activate([
            _buttonStackView.heightAnchor.constraint(equalToConstant: 100),
            _buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            _buttonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            _buttonStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40)
        ])
    }
}

// MARK: - Actions
extension HomeViewController {
    @objc private func _tappedBlockButton() {
        _youTubeBlocker.block { result in
            switch result {
            case .success():
                print("Khoá thành công")
            case .failure(let error):
                print("Khoá lỗi: \(error.localizedDescription)")
            }
        }
    }
    
    @objc private func _tappedReleaseButton() {
        _youTubeBlocker.unblockAllApps()
    }
    
    private func _requestAuthorization() {
        Task {
            do {
                try await _center.requestAuthorization(for: .individual)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
