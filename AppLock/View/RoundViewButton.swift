//
//  RoundViewButton.swift
//  AppLock
//
//  Created by Ipman on 22/05/2024.
//

import UIKit
class RoundViewButton: UIButton{
    override func awakeFromNib() {
        super.awakeFromNib()
        makeRounded(borderColor: .darkText, borderWidth: 1)
    }
}
