//
//  SandboxPermissionsAnalyzer.swift
//  ios-security-scanner
//
//  Created by Ali Al-Khazali on 5/5/25.
//

import Foundation

struct SandboxPermissionsAnalyzer {
    static func analyze(plist: [String: Any]) -> String {
        guard let entitlements = plist["com.apple.security.app-sandbox"] as? Bool, entitlements else {
            return "✅ App Sandbox not explicitly disabled"
        }

        var findings: [String] = []
        
        let sensitiveKeys = [
            "com.apple.security.files.user-selected.read-write",
            "com.apple.security.device.camera",
            "com.apple.security.device.microphone",
            "com.apple.security.network.client"
        ]

        for key in sensitiveKeys {
            if plist[key] != nil {
                findings.append("⚠️ Sensitive entitlement detected: \(key)")
            }
        }

        return findings.isEmpty
            ? "✅ No sensitive sandbox entitlements found"
            : findings.joined(separator: "\n")
    }
}
