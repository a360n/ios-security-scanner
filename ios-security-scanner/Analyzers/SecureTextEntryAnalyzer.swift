//
//  SecureTextEntryAnalyzer.swift
//  ios-security-scanner
//
//  Created by Ali Al-Khazali on 5/5/25.
//

import Foundation

struct SecureTextEntryAnalyzer {
    static func analyze(plist: [String: Any]) -> String {
        if let secureEntry = plist["UIRequiresSecureTextEntry"] as? Bool {
            return secureEntry
                ? "✅ UIRequiresSecureTextEntry is enabled – Secure input enforced"
                : "⚠️ UIRequiresSecureTextEntry is disabled – Keyboard input may be exposed"
        } else {
            return "ℹ️ UIRequiresSecureTextEntry key not found – Cannot determine keyboard input security"
        }
    }
}
