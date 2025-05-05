//
//  HardcodedSecretsAnalyzer.swift
//  ios-security-scanner
//
//  Created by Ali Al-Khazali on 5/4/25.
//


import Foundation

struct HardcodedSecretsAnalyzer {
    static let fileExtensions = ["swift", "plist", "json", "txt"]
    static let patterns: [String] = [
        #"(?i)(api[_-]?key|secret|token|pass(word)?)[\s:=]+['\"]?[\w\d\-]{10,}['\"]?"#,
        #"(?i)['\"]?[A-Za-z0-9]{32,}['\"]?"#  // Generic long secrets
    ]

    static func analyze(appPath: String) -> String {
        let fileManager = FileManager.default
        guard let enumerator = fileManager.enumerator(atPath: appPath) else {
            return "❌ Failed to read .app contents"
        }

        var findings: [String] = []

        for case let file as String in enumerator {
            let fileURL = URL(fileURLWithPath: appPath).appendingPathComponent(file)
            let ext = fileURL.pathExtension.lowercased()

            guard fileExtensions.contains(ext) else { continue }

            if let content = try? String(contentsOf: fileURL, encoding: .utf8) {
                for pattern in patterns {
                    if let regex = try? NSRegularExpression(pattern: pattern) {
                        let matches = regex.matches(in: content, range: NSRange(content.startIndex..., in: content))
                        if !matches.isEmpty {
                            findings.append("📄 \(file): \(matches.count) match(es)")
                        }
                    }
                }
            }
        }

        if findings.isEmpty {
            return "✅ No hardcoded secrets or API keys found"
        } else {
            return "❌ Potential hardcoded secrets found:\n" + findings.joined(separator: "\n")
        }
    }
}
