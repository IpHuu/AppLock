//
//  YouTubeBlocker.swift
//  ScreenTimeAPIExample
//
//  Created by Doyeon on 2023/04/26.
//

import Foundation
import ManagedSettings
import DeviceActivity

struct YouTubeBlocker {
    
    let store = ManagedSettingsStore()
    let model = BlockingApplicationModel.shared
    
    func block(completion: @escaping (Result<Void, Error>) -> Void) {
        let selectedApp = model.newSelection
        model.saveFamilyActivitySelection(selection: selectedApp)
        print("App đã chọn: " +  model.selectedAppCount.description)
        let selectedAppTokens = model.selectedAppsTokens
        
        let deviceActivityCenter = DeviceActivityCenter()
        
        
        let blockSchedule = DeviceActivitySchedule(
            intervalStart: DateComponents(hour: 0, minute: 0),
            intervalEnd: DateComponents(hour: 23, minute: 59),
            repeats: true
        )
        
        store.shield.applications = selectedAppTokens
        store.application.blockedApplications = selectedApp.applications
        
        do {
            try deviceActivityCenter.startMonitoring(DeviceActivityName.daily, during: blockSchedule)
        } catch {
            completion(.failure(error))
            return
        }
        model.getSavedFamilyActivitySelection()
        completion(.success(()))
    }
    
    func unblockAllApps() {
        print("App đã huỷ: " +  model.selectedAppCount.description)
        store.shield.applications = []
        store.application.blockedApplications = []
    }
    
    func getAppSelected() -> Int{
        if let selection = model.getSavedFamilyActivitySelection(){
            model.newSelection = selection
        }
        print("App đã chọn: " +  model.selectedAppCount.description)
        return model.selectedAppCount
    }
    
}
