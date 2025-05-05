//
//  PersistentWiFiAnalyzer.swift
//  ios-security-scanner
//
//  Created by Ali Al-Khazali on 5/5/25.
//

import Foundation

struct PersistentWiFiAnalyzer {
    static func analyze(plist: [String: Any]) -> String {
        if let value = plist["UIRequiresPersistentWiFi"] as? Bool {
            return value
                ? "⚠️ UIRequiresPersistentWiFi is enabled – may expose sensitive network activity"
                : "✅ UIRequiresPersistentWiFi is FALSE"
        }
        return "✅ UIRequiresPersistentWiFi not set (default is FALSE)"
    }
}
