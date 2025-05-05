//
//  URLProtocolAnalyzer.swift
//  ios-security-scanner
//
//  Created by Ali Al-Khazali on 5/5/25.
//

import Foundation

struct URLProtocolAnalyzer {
    static let insecureProtocols = ["http://", "ftp://", "file://", "telnet://"]

    static func analyze(plist: [String: Any]) -> String {
        var findings: [String] = []

        if let urlTypes = plist["CFBundleURLTypes"] as? [[String: Any]] {
            for type in urlTypes {
                if let schemes = type["CFBundleURLSchemes"] as? [String] {
                    for scheme in schemes {
                        for proto in insecureProtocols {
                            if scheme.lowercased().hasPrefix(proto) {
                                findings.append("⚠️ Insecure URL Scheme detected: \(scheme)")
                            }
                        }
                    }
                }
            }
        }

        return findings.isEmpty
            ? "✅ No insecure URL protocols or schemes found"
            : findings.joined(separator: "\n")
    }
}
