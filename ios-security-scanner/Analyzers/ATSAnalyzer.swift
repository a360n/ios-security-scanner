//
//  ATSAnalyzer.swift
//  ios-security-scanner
//
//  Created by Ali Al-Khazali on 5/4/25.
//

import Foundation

struct ATSAnalyzer {
    static func analyze(plist: [String: Any]) -> String {
        if let ats = plist["NSAppTransportSecurity"] as? [String: Any] {
            // Check if ATS is disabled
            if let allowsInsecureLoads = ats["NSAllowsArbitraryLoads"] as? Bool, allowsInsecureLoads {
                return "❌ ATS is DISABLED (NSAllowsArbitraryLoads = true)"
            } else {
                return "✅ ATS is enabled (no NSAllowsArbitraryLoads = true found)"
            }
        } else {
            return "⚠️ NSAppTransportSecurity not configured (default ATS is enabled)"
        }
    }
}

