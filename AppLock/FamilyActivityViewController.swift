//
//  FamilyActivityViewController.swift
//  AppLock
//
//  Created by Ipman on 22/05/2024.
//

import Foundation
import UIKit
import SwiftUI
import FamilyControls

class FamilyActivityPickerViewController: UIHostingController<FamilyActivityPicker>{
    required init?(coder aDecoder: NSCoder) {
        let viewmodel = FamilyActivityViewModel()
        let picker = FamilyActivityPicker(selection: Binding(
            get: {viewmodel.selectionToDiscourage}, set: {viewmodel.selectionToDiscourage = $0}
        ))
        super.init(coder: aDecoder, rootView: picker)
    }
    init() {
        let viewModel = FamilyActivityViewModel()
        let picker = FamilyActivityPicker(selection: Binding(
            get: { viewModel.selection },
            set: { viewModel.selection = $0 }
        ))
        super.init(rootView: picker)
    }
}
