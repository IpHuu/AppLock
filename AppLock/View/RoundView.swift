//
//  RoundView.swift
//  AppLock
//
//  Created by Ipman on 22/05/2024.
//

import UIKit
class RoundView: UIView{
    override func awakeFromNib() {
        super.awakeFromNib()
        
        makeRounded(borderColor: .darkText, borderWidth: 1.0)
        // Add gesture recognizer to handle touch events
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        self.addGestureRecognizer(tapGestureRecognizer)
        
        // Enable user interaction
        self.isUserInteractionEnabled = true
    }
    
    var isActive: Bool = false{
        didSet{
            makeRounded(borderColor: .darkText, borderWidth: 1.0, isActive: isActive)
        }
    }
    
    @objc private func viewTapped() {
        // Toggle the isActive property when the view is tapped
        isActive.toggle()
        
        // Update the view appearance based on isActive state
        if isActive {
            self.layer.borderColor = UIColor.systemGreen.cgColor
            self.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.3)
        } else {
            self.layer.borderColor = UIColor.darkText.cgColor
            self.backgroundColor = UIColor.clear
        }
    }
}
