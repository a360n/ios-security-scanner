//
//  ThirdPartySDKAnalyzer.swift
//  ios-security-scanner
//
//  Created by Ali Al-Khazali on 5/5/25.
//

import Foundation

struct ThirdPartySDKAnalyzer {
    static let knownSDKs = [
        "FacebookSDK": "⚠️ Facebook SDK detected (may track users)",
        "FirebaseAnalytics": "⚠️ Firebase Analytics detected (tracks usage)",
        "AppsFlyer": "⚠️ AppsFlyer SDK detected (used for attribution)",
        "AdMob": "⚠️ Google AdMob detected (ads and user profiling)",
        "Adjust": "⚠️ Adjust SDK detected (used for ad attribution)",
        "OneSignal": "⚠️ OneSignal detected (push notification tracking)",
        "Mixpanel": "⚠️ Mixpanel SDK detected (user analytics)",
        "Branch": "⚠️ Branch SDK detected (deep linking + attribution)",
        "GoogleTagManager": "⚠️ Google Tag Manager detected (tracking events)"
    ]

    static func analyze(appPath: String) -> String {
        let frameworksPath = "\(appPath)/Frameworks"
        var results: [String] = []

        for (sdkName, warning) in knownSDKs {
            let sdkPath = "\(frameworksPath)/\(sdkName).framework"
            if FileManager.default.fileExists(atPath: sdkPath) {
                results.append(warning)
            }
        }

        return results.isEmpty
            ? "✅ No known third-party SDKs detected"
            : results.joined(separator: "\n")
    }
}
