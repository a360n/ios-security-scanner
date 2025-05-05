//
//  FrameworkSignatureAnalyzer.swift
//  ios-security-scanner
//
//  Created by Ali Al-Khazali on 5/4/25.
//


import Foundation

struct FrameworkSignatureAnalyzer {
    static func analyze(appPath: String) -> String {
        let frameworksPath = (appPath as NSString).appendingPathComponent("Frameworks")
        let fileManager = FileManager.default

        guard fileManager.fileExists(atPath: frameworksPath) else {
            return "✅ No embedded frameworks found"
        }

        guard let contents = try? fileManager.contentsOfDirectory(atPath: frameworksPath) else {
            return "❌ Failed to read Frameworks directory"
        }

        var findings: [String] = []

        for file in contents where file.hasSuffix(".framework") {
            let frameworkPath = (frameworksPath as NSString).appendingPathComponent(file)
            let task = Process()
            task.executableURL = URL(fileURLWithPath: "/usr/bin/codesign")
            task.arguments = ["-d", frameworkPath]

            let pipe = Pipe()
            task.standardOutput = pipe
            task.standardError = pipe

            do {
                try task.run()
                let data = pipe.fileHandleForReading.readDataToEndOfFile()
                let output = String(decoding: data, as: UTF8.self)

                if output.contains("code object is not signed") {
                    findings.append("❌ \(file) is NOT signed")
                } else if file.lowercased().contains("debug") || output.contains("DEBUG") {
                    findings.append("⚠️ \(file) might be a Debug build")
                } else {
                    findings.append("✅ \(file) appears signed and safe")
                }
            } catch {
                findings.append("❌ Failed to analyze \(file): \(error.localizedDescription)")
            }
        }

        return findings.isEmpty ? "✅ No frameworks found" : findings.joined(separator: "\n")
    }
}
