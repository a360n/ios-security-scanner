//
//  PrivacyPermissionsAnalyzer.swift
//  ios-security-scanner
//
//  Created by Ali Al-Khazali on 5/5/25.
//

import Foundation

struct PrivacyPermissionsAnalyzer {
    static let sensitiveKeys = [
        "NSCameraUsageDescription",
        "NSMicrophoneUsageDescription",
        "NSLocationWhenInUseUsageDescription",
        "NSLocationAlwaysUsageDescription",
        "NSPhotoLibraryUsageDescription",
        "NSContactsUsageDescription",
        "NSBluetoothAlwaysUsageDescription",
        "NSFaceIDUsageDescription",
        "NSHealthShareUsageDescription",
        "NSHealthUpdateUsageDescription",
        "NSMotionUsageDescription",
        "NSCalendarsUsageDescription",
        "NSRemindersUsageDescription",
        "NSSpeechRecognitionUsageDescription"
    ]

    static func analyze(plist: [String: Any]) -> String {
        var results: [String] = []

        for key in sensitiveKeys {
            if let value = plist[key] as? String {
                results.append("✅ \(key) is present with description: \"\(value)\"")
            } else {
                results.append("⚠️ \(key) is missing")
            }
        }

        return results.joined(separator: "\n")
    }
}
