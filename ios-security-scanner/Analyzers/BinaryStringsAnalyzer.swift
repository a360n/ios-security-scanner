//
//  BinaryStringsAnalyzer.swift
//  ios-security-scanner
//
//  Created by Ali Al-Khazali on 5/5/25.
//

import Foundation

struct BinaryStringsAnalyzer {
    static func analyze(appPath: String) -> String {
        let executableFiles = try? FileManager.default.contentsOfDirectory(atPath: appPath).filter {
            !$0.contains(".")
        }

        guard let binaries = executableFiles, !binaries.isEmpty else {
            return "❌ No binary executables found to scan"
        }

        var findings: [String] = []

        for binary in binaries {
            let fullPath = "\(appPath)/\(binary)"
            let task = Process()
            task.launchPath = "/usr/bin/strings"
            task.arguments = [fullPath]

            let pipe = Pipe()
            task.standardOutput = pipe

            do {
                try task.run()
                let data = pipe.fileHandleForReading.readDataToEndOfFile()
                if let output = String(data: data, encoding: .utf8) {
                    let lines = output.split(separator: "\n")

                    for line in lines {
                        let str = line.trimmingCharacters(in: .whitespaces)
                        if str.lowercased().contains("api")
                            || str.lowercased().contains("key")
                            || str.lowercased().contains("password")
                            || str.contains("http://")
                            || str.contains("https://")
                            || str.contains("/bin/")
                            || str.contains("system(")
                        {
                            findings.append("🔍 \(str)")
                        }
                    }
                }
            } catch {
                findings.append("❌ Could not scan binary: \(binary)")
            }
        }

        return findings.isEmpty
            ? "✅ No suspicious strings found in binaries"
            : findings.prefix(20).joined(separator: "\n") + "\n... (truncated)"
    }
}
