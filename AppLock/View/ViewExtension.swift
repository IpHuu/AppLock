//
//  RoundViewExtension.swift
//  AppLock
//
//  Created by Ipman on 22/05/2024.
//

import UIKit
extension UIView{
    func makeRounded(borderColor: UIColor, borderWidth: CGFloat, isActive: Bool = false){
        layer.cornerRadius = (frame.size.width < frame.size.height) ? frame.size.width / 2.0 : frame.size.height / 2.0
        layer.borderColor = borderColor.cgColor
        layer.backgroundColor = isActive ? borderColor.cgColor : UIColor.white.cgColor
        layer.borderWidth = borderWidth
    }
}
