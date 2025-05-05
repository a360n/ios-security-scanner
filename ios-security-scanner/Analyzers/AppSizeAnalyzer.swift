//
//  AppSizeAnalyzer.swift
//  ios-security-scanner
//
//  Created by Ali Al-Khazali on 5/4/25.
//


import Foundation

struct AppSizeAnalyzer {
    static func analyze(appPath: String) -> String {
        let fileManager = FileManager.default
        guard let enumerator = fileManager.enumerator(atPath: appPath) else {
            return "❌ Failed to enumerate .app contents"
        }

        var totalSize: UInt64 = 0
        var fileCount = 0

        for case let file as String in enumerator {
            let fullPath = (appPath as NSString).appendingPathComponent(file)
            var isDir: ObjCBool = false
            if fileManager.fileExists(atPath: fullPath, isDirectory: &isDir), !isDir.boolValue {
                if let attrs = try? fileManager.attributesOfItem(atPath: fullPath),
                   let fileSize = attrs[.size] as? UInt64 {
                    totalSize += fileSize
                    fileCount += 1
                }
            }
        }

        let sizeInMB = Double(totalSize) / (1024.0 * 1024.0)
        let roundedSize = String(format: "%.2f", sizeInMB)

        var status = "✅"
        if sizeInMB > 50 {
            status = "❌"
        } else if sizeInMB > 25 {
            status = "⚠️"
        }

        return "\(status) App size: \(roundedSize) MB | Files: \(fileCount)"
    }
}
