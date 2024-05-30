//
//  MyModel.swift
//  ScreenTimeAPIExample
//
//  Created by Doyeon on 2023/04/26.
//

import Foundation
import FamilyControls
import ManagedSettings

final class BlockingApplicationModel: ObservableObject {
    static let shared = BlockingApplicationModel()
    // Used to encode codable to UserDefaults
    private let encoder = PropertyListEncoder()

    // Used to decode codable from UserDefaults
    private let decoder = PropertyListDecoder()
    @Published var newSelection: FamilyActivitySelection = .init()
    
    var selectedAppsTokens: Set<ApplicationToken> {
        newSelection.applicationTokens
    }
    
    var selectedAppCount: Int{
        newSelection.applicationTokens.count
    }
    
    private let userDefaultsKey = "ScreenTimeSelection"
    
    
    //save family activity selection to UserDefault
    func saveFamilyActivitySelection(selection: FamilyActivitySelection) {
        print("selected app updated: ", selection.applicationTokens.count," category: ", selection.categoryTokens.count)
        let defaults = UserDefaults.standard

        defaults.set(
            try? encoder.encode(selection),
            forKey: userDefaultsKey
        )
        
        //check is data saved to user defaults
        getSavedFamilyActivitySelection()
    }
    
    //get saved family activity selection from UserDefault
    func getSavedFamilyActivitySelection() -> FamilyActivitySelection? {
        let defaults = UserDefaults.standard
        guard let data = defaults.data(forKey: userDefaultsKey) else {
            return nil
        }
        var selectedApp: FamilyActivitySelection?
        let decoder = PropertyListDecoder()
        selectedApp = try? decoder.decode(FamilyActivitySelection.self, from: data)
        
        print("saved selected app updated: ", selectedApp?.categoryTokens.count ?? "0")
        return selectedApp
    }
    
    
}
