//
//  ShellExecutor.swift
//  ios-security-scanner
//
//  Created by Ali Al-Khazali on 5/4/25.
//

import Foundation

struct ShellExecutor {
    @discardableResult
    static func run(_ command: String, arguments: [String] = []) -> String {
        let process = Process()
        process.executableURL = URL(fileURLWithPath: "/usr/bin/env")
        process.arguments = [command] + arguments

        let pipe = Pipe()
        process.standardOutput = pipe
        process.standardError = pipe

        do {
            try process.run()
        } catch {
            return "❌ Failed to run command: \(command)"
        }

        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output = String(decoding: data, as: UTF8.self)
        return output.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
