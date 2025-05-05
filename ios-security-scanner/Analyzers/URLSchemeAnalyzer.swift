//
//  URLSchemeAnalyzer.swift
//  ios-security-scanner
//
//  Created by Ali Al-Khazali on 5/4/25.
//

import Foundation

struct URLSchemeAnalyzer {
    static let insecureSchemes = ["http", "ftp", "file", "tel", "sms", "fb", "custom"]

    static func analyze(plist: [String: Any]) -> String {
        guard let urlTypes = plist["CFBundleURLTypes"] as? [[String: Any]] else {
            return "✅ No custom URL schemes found"
        }

        var insecureFound = [String]()

        for type in urlTypes {
            if let schemes = type["CFBundleURLSchemes"] as? [String] {
                for scheme in schemes {
                    let lowercasedScheme = scheme.lowercased()
                    if insecureSchemes.contains(where: { lowercasedScheme.contains($0) }) {
                        insecureFound.append(scheme)
                    }
                }
            }
        }

        if insecureFound.isEmpty {
            return "✅ All URL schemes appear safe"
        } else {
            return "❌ Insecure or custom URL schemes found: \(insecureFound.joined(separator: ", "))"
        }
    }
}

