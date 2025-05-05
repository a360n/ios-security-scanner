//
//  IndirectInputAnalyzer.swift
//  ios-security-scanner
//
//  Created by Ali Al-Khazali on 5/5/25.
//

import Foundation

struct IndirectInputAnalyzer {
    static func analyze(plist: [String: Any]) -> String {
        if let value = plist["UIApplicationSupportsIndirectInputEvents"] as? Bool {
            return value
                ? "⚠️ UIApplicationSupportsIndirectInputEvents is enabled – review if needed"
                : "✅ UIApplicationSupportsIndirectInputEvents is FALSE"
        }
        return "✅ UIApplicationSupportsIndirectInputEvents not set (default is FALSE)"
    }
}
