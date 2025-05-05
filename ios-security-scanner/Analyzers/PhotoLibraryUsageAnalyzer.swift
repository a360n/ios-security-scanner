//
//  PhotoLibraryUsageAnalyzer.swift
//  ios-security-scanner
//
//  Created by Ali Al-Khazali on 5/5/25.
//

import Foundation

struct PhotoLibraryUsageAnalyzer {
    static func analyze(plist: [String: Any]) -> String {
        var results: [String] = []

        if let readAccess = plist["NSPhotoLibraryUsageDescription"] as? String {
            results.append("Photo Library read access requested: \"\(readAccess)\"")
        }

        if let writeAccess = plist["NSPhotoLibraryAddUsageDescription"] as? String {
            results.append("Photo Library write access requested: \"\(writeAccess)\"")
        }

        return results.isEmpty
            ? "✅ No photo library permissions requested"
            : results.joined(separator: "\n")
    }
}
