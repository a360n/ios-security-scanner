//
//  InsecureNetworkAnalyzer.swift
//  ios-security-scanner
//
//  Created by Ali Al-Khazali on 5/5/25.
//

import Foundation

struct InsecureNetworkAnalyzer {
    static func analyze(plist: [String: Any]) -> String {
        guard let ats = plist["NSAppTransportSecurity"] as? [String: Any] else {
            return "✅ Default ATS policy is enforced (no exceptions found)"
        }

        var result = [String]()

        if let allowsArbitraryLoads = ats["NSAllowsArbitraryLoads"] as? Bool, allowsArbitraryLoads {
            result.append("⚠️ NSAllowsArbitraryLoads = true (all HTTP connections are allowed)")
        }

        if let domains = ats["NSExceptionDomains"] as? [String: Any] {
            for (domain, settings) in domains {
                if let domainDict = settings as? [String: Any],
                   let allowInsecure = domainDict["NSExceptionAllowsInsecureHTTPLoads"] as? Bool,
                   allowInsecure {
                    result.append("⚠️ NSExceptionAllowsInsecureHTTPLoads = true for domain: \(domain)")
                }
            }
        }

        return result.isEmpty
            ? "✅ ATS is enforced, no insecure exceptions found"
            : result.joined(separator: "\n")
    }
}
