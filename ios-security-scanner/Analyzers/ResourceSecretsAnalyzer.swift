//
//  ResourceSecretsAnalyzer.swift
//  ios-security-scanner
//
//  Created by Ali Al-Khazali on 5/5/25.
//

import Foundation

struct ResourceSecretsAnalyzer {
    static func analyze(appPath: String) -> String {
        let fileExtensions = ["json", "plist", "strings", "txt"]
        let secretPatterns = [
            #"(?i)(api|access|auth|secret|token|key)[\s"':=]+[a-z0-9_\-]{8,}"#,
            #"(?i)password[\s"':=]+[^\s]+"#
        ]

        var matches: [String] = []

        let fm = FileManager.default
        guard let enumerator = fm.enumerator(atPath: appPath) else {
            return "❌ Could not read app bundle."
        }

        for case let file as String in enumerator {
            if fileExtensions.contains(where: { file.lowercased().hasSuffix($0) }) {
                let fullPath = "\(appPath)/\(file)"
                if let content = try? String(contentsOfFile: fullPath, encoding: .utf8) {
                    for pattern in secretPatterns {
                        if let regex = try? NSRegularExpression(pattern: pattern, options: []) {
                            let range = NSRange(location: 0, length: content.utf16.count)
                            let results = regex.matches(in: content, options: [], range: range)
                            if !results.isEmpty {
                                matches.append(" \(file): found \(results.count) potential secrets")
                            }
                        }
                    }
                }
            }
        }

        return matches.isEmpty
            ? "✅ No secrets found in resource files"
            : matches.joined(separator: "\n")
    }
}
