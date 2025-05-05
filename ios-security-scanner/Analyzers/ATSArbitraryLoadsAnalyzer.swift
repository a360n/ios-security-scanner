//
//  ATSArbitraryLoadsAnalyzer.swift
//  ios-security-scanner
//
//  Created by Ali Al-Khazali on 5/5/25.
//

import Foundation

struct ATSArbitraryLoadsAnalyzer {
    static func analyze(plist: [String: Any]) -> String {
        if let ats = plist["NSAppTransportSecurity"] as? [String: Any],
           let allowsAll = ats["NSAllowsArbitraryLoads"] as? Bool {
            if allowsAll {
                return "❌ NSAllowsArbitraryLoads is set to TRUE – ATS is disabled globally"
            } else {
                return "✅ NSAllowsArbitraryLoads is FALSE"
            }
        }
        return "✅ NSAllowsArbitraryLoads not explicitly set (default is FALSE)"
    }
}
