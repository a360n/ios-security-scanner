//
//  LocationUsageAnalyzer.swift
//  ios-security-scanner
//
//  Created by Ali Al-Khazali on 5/5/25.
//

import Foundation

struct LocationUsageAnalyzer {
    static func analyze(plist: [String: Any]) -> String {
        let locationKeys = [
            "NSLocationWhenInUseUsageDescription",
            "NSLocationAlwaysUsageDescription",
            "NSLocationAlwaysAndWhenInUseUsageDescription"
        ]

        var findings: [String] = []

        for key in locationKeys {
            if let value = plist[key] as? String {
                findings.append("⚠️ \(key) is set: \"\(value)\"")
            }
        }

        return findings.isEmpty
            ? "✅ No location usage descriptions found"
            : findings.joined(separator: "\n")
    }
}
