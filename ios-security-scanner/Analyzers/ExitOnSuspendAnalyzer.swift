//
//  ExitOnSuspendAnalyzer.swift
//  ios-security-scanner
//
//  Created by Ali Al-Khazali on 5/4/25.
//


import Foundation

struct ExitOnSuspendAnalyzer {
    static func analyze(plist: [String: Any]) -> String {
        if let exits = plist["UIApplicationExitsOnSuspend"] as? Bool {
            if exits {
                return "❌ UIApplicationExitsOnSuspend is ENABLED (suspicious behavior)"
            } else {
                return "✅ UIApplicationExitsOnSuspend is disabled"
            }
        } else {
            return "✅ UIApplicationExitsOnSuspend not set (default is disabled)"
        }
    }
}
