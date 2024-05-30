//
//  FamilyActivityViewModel.swift
//  AppLock
//
//  Created by Ipman on 22/05/2024.
//

import Foundation
import FamilyControls
import DeviceActivity
import ManagedSettings
import Combine
import SwiftUI
class FamilyActivityViewModel: ObservableObject{
    @Published var selection = FamilyActivitySelection()
    let store = ManagedSettingsStore()
    @Published var selectionToDiscourage = FamilyActivitySelection() {
        willSet {
            print ("got here \(newValue)")
            let applications = newValue.applicationTokens
            let categories = newValue.categoryTokens
            //let webCategories = newValue.webDomainTokens
            store.shield.applications = applications.isEmpty ? nil : applications
            store.shield.applicationCategories = ShieldSettings.ActivityCategoryPolicy.specific(categories, except: Set())
            store.shield.webDomainCategories = ShieldSettings.ActivityCategoryPolicy.specific(categories, except: Set())

        }
    }
}
