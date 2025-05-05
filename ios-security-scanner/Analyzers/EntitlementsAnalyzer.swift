//
//  EntitlementsAnalyzer.swift
//  ios-security-scanner
//
//  Created by Ali Al-Khazali on 5/4/25.
//


import Foundation

struct EntitlementsAnalyzer {
    static func analyzeCodeSign(at path: String) -> String {
        let task = Process()
        task.executableURL = URL(fileURLWithPath: "/usr/bin/codesign")
        task.arguments = ["-d", "--entitlements", ":-", path]

        let pipe = Pipe()
        task.standardOutput = pipe
        task.standardError = pipe

        do {
            try task.run()
        } catch {
            return "❌ Failed to run codesign: \(error.localizedDescription)"
        }

        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        guard let output = String(data: data, encoding: .utf8) else {
            return "❌ Failed to read codesign output"
        }

        if output.contains("<key>get-task-allow</key>") {
            if output.contains("<true/>") {
                return "❌ Debug mode is ENABLED in code signature"
            } else if output.contains("<false/>") {
                return "✅ Debug mode is disabled in code signature"
            }
        }

        return "⚠️ get-task-allow not found in code signature (assumed secure)"
    }
}
