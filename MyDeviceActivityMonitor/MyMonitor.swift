//
//  MyMonitor.swift
//  MyDeviceActivityMonitor
//
//  Created by Ipman on 22/05/2024.
//

import Foundation
import UIKit
import MobileCoreServices
import ManagedSettings
import DeviceActivity

class MyMonitor: DeviceActivityMonitor{
    let store = ManagedSettingsStore()
    
    override func intervalDidStart(for activity: DeviceActivityName) {
        super.intervalDidStart(for: activity)
        print("interval did start")
        let model = MyModel.shared
        let application = model.selectionToDiscourage.applicationTokens
        store.shield.applications = application.isEmpty ? nil : application
        store.dateAndTime.requireAutomaticDateAndTime = true
        
    }
    
    override func intervalDidEnd(for activity: DeviceActivityName) {
        super.intervalDidEnd(for: activity)
        store.shield.applications = nil
        store.dateAndTime.requireAutomaticDateAndTime = false
    }
    
}
