//
//  HTTPURLAnalyzer.swift
//  ios-security-scanner
//
//  Created by Ali Al-Khazali on 5/4/25.
//


import Foundation

struct HTTPURLAnalyzer {
    static let fileExtensions = ["swift", "plist", "json", "txt"]

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
                let lines = content.components(separatedBy: .newlines)
                for (index, line) in lines.enumerated() {
                    if line.contains("http://") {
                        findings.append("📄 \(file) (line \(index + 1))")
                    }
                }
            }
        }

        if findings.isEmpty {
            return "✅ No insecure http:// URLs found"
        } else {
            return "❌ Insecure URLs found:\n" + findings.joined(separator: "\n")
        }
    }
}
