//
//  UIFileSharingAnalyzer.swift
//  ios-security-scanner
//
//  Created by Ali Al-Khazali on 5/4/25.
//

import Foundation

struct UIFileSharingAnalyzer {
    static func analyze(plist: [String: Any]) -> String {
        if let isEnabled = plist["UIFileSharingEnabled"] as? Bool {
            if isEnabled {
                return "❌ UIFileSharing is ENABLED (users can access app files via iTunes)"
            } else {
                return "✅ UIFileSharing is disabled"
            }
        } else {
            return "✅ UIFileSharingEnabled not set (default is disabled)"
        }
    }
}
