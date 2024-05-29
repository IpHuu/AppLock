//
//  LanguageManager.swift
//  AppLock
//
//  Created by Ipman on 23/05/2024.
//

import Foundation
class LanguageManager {
    static let shared = LanguageManager()
    private init(){}
    
    func changeLanguage(_ language: Language) {
        UserDefaults.standard.set(language.rawValue, forKey: "APP_LANGUAGE")
        NotificationCenter.default.post(name: .languageChange, object: nil)
    }

    func getAppLanguage() -> Language {
        if let language = UserDefaults.standard.value(forKey: "APP_LANGUAGE") as? String {
            return Language(rawValue: language) ?? .english
        } else {
            let currentLanguage: String = Locale.current.language.languageCode?.identifier ?? Language.english.rawValue
            return Language(rawValue: currentLanguage) ?? .english
        }
    }
    
    enum Language: String {
        case vietnamese = "vi"
        case english = "en"
        case chinese = "zh-Hans"
    }
}
extension String {
    var localized: String {
        let currentLanguage = LanguageManager.shared.getAppLanguage().rawValue
        guard let bundlePath = Bundle.main.path(forResource: currentLanguage, ofType: "lproj"), let bundle = Bundle(path: bundlePath) else {
            return self
        }
        return NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")
    }
}

extension Notification.Name{
    static let languageChange = Notification.Name("languageChanged")
}
