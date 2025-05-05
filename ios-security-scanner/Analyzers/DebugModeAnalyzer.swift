//
//  DebugModeAnalyzer.swift
//  ios-security-scanner
//
//  Created by Ali Al-Khazali on 5/4/25.
//


import Foundation

struct DebugModeAnalyzer {
    static func analyze(plist: [String: Any]) -> String {
        if let entitlements = plist["get-task-allow"] as? Bool {
            if entitlements {
                return "❌ Debug mode is ENABLED (get-task-allow = true)"
            } else {
                return "✅ Debug mode is disabled (get-task-allow = false)"
            }
        } else {
            return "⚠️ get-task-allow key not found (assumed secure)"
        }
    }
}
