//
//  BackgroundModesAnalyzer.swift
//  ios-security-scanner
//
//  Created by Ali Al-Khazali on 5/4/25.
//


import Foundation

struct BackgroundModesAnalyzer {
    static func analyze(plist: [String: Any]) -> String {
        guard let modes = plist["UIBackgroundModes"] as? [String] else {
            return "✅ No background modes declared"
        }

        if modes.isEmpty {
            return "✅ UIBackgroundModes is empty"
        }

        let commonRisks = ["location", "audio", "voip", "fetch"]
        let riskyModes = modes.filter { commonRisks.contains($0) }

        if riskyModes.isEmpty {
            return "⚠️ Background modes declared but not risky: \(modes.joined(separator: ", "))"
        } else {
            return "❌ Risky background modes found: \(riskyModes.joined(separator: ", "))"
        }
    }
}
