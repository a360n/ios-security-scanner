//
//  CameraMicrophoneUsageAnalyzer.swift
//  ios-security-scanner
//
//  Created by Ali Al-Khazali on 5/5/25.
//

import Foundation

struct CameraMicrophoneUsageAnalyzer {
    static func analyze(plist: [String: Any]) -> String {
        var results: [String] = []

        if let camera = plist["NSCameraUsageDescription"] as? String {
            results.append("Camera access requested: \"\(camera)\"")
        }

        if let mic = plist["NSMicrophoneUsageDescription"] as? String {
            results.append(" Microphone access requested: \"\(mic)\"")
        }

        return results.isEmpty
            ? "✅ No camera or microphone permissions requested"
            : results.joined(separator: "\n")
    }
}
