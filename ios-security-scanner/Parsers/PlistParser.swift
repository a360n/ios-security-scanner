//
//  PlistParser.swift
//  ios-security-scanner
//
//  Created by Ali Al-Khazali on 5/4/25.
//


import Foundation

struct PlistParser {
    static func parsePlist(at path: String) -> [String: Any]? {
        let url = URL(fileURLWithPath: path)

        guard FileManager.default.fileExists(atPath: path) else {
            print("❌ File not found at \(path)")
            return nil
        }

        do {
            let data = try Data(contentsOf: url)
            let plist = try PropertyListSerialization.propertyList(
                from: data,
                options: [],
                format: nil
            )
            return plist as? [String: Any]
        } catch {
            print("❌ Failed to parse plist at \(path): \(error.localizedDescription)")
            return nil
        }
    }
}
