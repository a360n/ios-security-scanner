//
//  SensitiveFilesAnalyzer.swift
//  ios-security-scanner
//
//  Created by Ali Al-Khazali on 5/4/25.
//

import Foundation

struct SensitiveFilesAnalyzer {
    static let suspiciousFilenames = [
        ".env", ".env.local", "debug.log", "config.json", "keys.json",
        "README.md", "test.txt", "notes.txt", ".DS_Store", ".git", "secret.txt"
    ]

    static func analyze(appPath: String) -> String {
        let fileManager = FileManager.default
        guard let enumerator = fileManager.enumerator(atPath: appPath) else {
            return "❌ Failed to read .app contents"
        }

        var findings: [String] = []

        for case let file as String in enumerator {
            let lowercased = file.lowercased()
            if suspiciousFilenames.contains(where: { lowercased.hasSuffix($0) }) {
                findings.append("⚠️ Found: \(file)")
            }
        }

        if findings.isEmpty {
            return "✅ No suspicious or sensitive files found"
        } else {
            return "❌ Potential sensitive files detected:\n" + findings.joined(separator: "\n")
        }
    }
}
