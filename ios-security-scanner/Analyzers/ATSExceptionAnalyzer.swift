//
//  ATSExceptionAnalyzer.swift
//  ios-security-scanner
//
//  Created by Ali Al-Khazali on 5/5/25.
//

import Foundation

struct ATSExceptionAnalyzer {
    static func analyze(plist: [String: Any]) -> String {
        guard let ats = plist["NSAppTransportSecurity"] as? [String: Any] else {
            return "✅ NSAppTransportSecurity not configured (default ATS enforced)"
        }

        var results: [String] = []

        if let allowsWebContent = ats["NSAllowsArbitraryLoadsInWebContent"] as? Bool, allowsWebContent {
            results.append("⚠️ NSAllowsArbitraryLoadsInWebContent is enabled – ATS weakened for web views.")
        }

        if let exceptions = ats["NSExceptionDomains"] as? [String: Any], !exceptions.isEmpty {
            results.append("⚠️ NSExceptionDomains present – specific domains may bypass ATS:")
            for (domain, config) in exceptions {
                results.append("   🔹 \(domain): \(config)")
            }
        }

        return results.isEmpty
            ? "✅ No ATS exceptions detected"
            : results.joined(separator: "\n")
    }
}
