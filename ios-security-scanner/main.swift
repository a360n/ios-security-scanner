//
//  main.swift
//  ios-security-scanner
//
//  Created by Ali Al-Khazali on 5/4/25.
//

import Foundation

let args = CommandLine.arguments

guard args.count > 1 else {
    print("Usage: ios-security-scanner <path_to_ipa_or_app>")
    exit(1)
}

let inputPath = args[1]
let reportName: String? = nil

print("Starting scan for: \(inputPath)")

let infoPlistPath = "\(inputPath)/Info.plist"

if let plist = PlistParser.parsePlist(at: infoPlistPath) {
    print("Info.plist parsed successfully")

    let atsResult = ATSAnalyzer.analyze(plist: plist)
    print("1. ATS Check Result:", atsResult)

    let debugResult = DebugModeAnalyzer.analyze(plist: plist)
    print("2. Debug Mode Check Result:", debugResult)

    let urlSchemeResult = URLSchemeAnalyzer.analyze(plist: plist)
    print("3. URL Schemes Check Result:", urlSchemeResult)

    let entitlementsResult = EntitlementsAnalyzer.analyzeCodeSign(at: inputPath)
    print("4. Entitlements Check Result:", entitlementsResult)

    let fileSharingResult = UIFileSharingAnalyzer.analyze(plist: plist)
    print("5. File Sharing Check Result:", fileSharingResult)

    let secretsResult = HardcodedSecretsAnalyzer.analyze(appPath: inputPath)
    print("6. Secrets Scan Result:\n\(secretsResult)")

    let httpResult = HTTPURLAnalyzer.analyze(appPath: inputPath)
    print("7. HTTP URL Scan Result:\n\(httpResult)")

    let sensitiveFilesResult = SensitiveFilesAnalyzer.analyze(appPath: inputPath)
    print("8. Sensitive Files Check Result:\n\(sensitiveFilesResult)")

    let backgroundModesResult = BackgroundModesAnalyzer.analyze(plist: plist)
    print("9. Background Modes Check Result:", backgroundModesResult)

    let exitOnSuspendResult = ExitOnSuspendAnalyzer.analyze(plist: plist)
    print("10. Exit on Suspend Check Result:", exitOnSuspendResult)

    let appSizeResult = AppSizeAnalyzer.analyze(appPath: inputPath)
    print("11. App Size Check Result:", appSizeResult)

    let frameworksResult = FrameworkSignatureAnalyzer.analyze(appPath: inputPath)
    print("12. Frameworks Check Result:\n\(frameworksResult)")

    let arbitraryLoadsResult = ATSArbitraryLoadsAnalyzer.analyze(plist: plist)
    print("13. ATS Arbitrary Loads Check Result:", arbitraryLoadsResult)

    let persistentWiFiResult = PersistentWiFiAnalyzer.analyze(plist: plist)
    print("14. Persistent WiFi Check Result:", persistentWiFiResult)

    let indirectInputResult = IndirectInputAnalyzer.analyze(plist: plist)
    print("15. Indirect Input Events Check Result:", indirectInputResult)

    let resourceSecretsResult = ResourceSecretsAnalyzer.analyze(appPath: inputPath)
    print("16. Resource Secrets Check Result:\n\(resourceSecretsResult)")

    let binaryStringsResult = BinaryStringsAnalyzer.analyze(appPath: inputPath)
    print("17. Binary Strings Check Result:\n\(binaryStringsResult)")

    let insecureNetworkResult = InsecureNetworkAnalyzer.analyze(plist: plist)
    print("18. Insecure Network Usage Check Result:\n\(insecureNetworkResult)")

    let privacyPermissionsResult = PrivacyPermissionsAnalyzer.analyze(plist: plist)
    print("19. Privacy Permissions Check Result:\n\(privacyPermissionsResult)")

    let sdkResult = ThirdPartySDKAnalyzer.analyze(appPath: inputPath)
    print("20. Third-Party SDK Check Result:\n\(sdkResult)")

    let urlProtocolResult = URLProtocolAnalyzer.analyze(plist: plist)
    print("21. URL Protocols Check Result:\n\(urlProtocolResult)")

    let atsExceptionsResult = ATSExceptionAnalyzer.analyze(plist: plist)
    print("22. ATS Exceptions Check Result:\n\(atsExceptionsResult)")

    let secureKeyboardResult = SecureTextEntryAnalyzer.analyze(plist: plist)
    print("23. Secure Text Entry Check Result:", secureKeyboardResult)

    let sandboxResult = SandboxPermissionsAnalyzer.analyze(plist: plist)
    print("24. App Sandbox Check Result:", sandboxResult)

    let locationUsageResult = LocationUsageAnalyzer.analyze(plist: plist)
    print("25. Location Usage Check Result:", locationUsageResult)

    let camMicResult = CameraMicrophoneUsageAnalyzer.analyze(plist: plist)
    print("26. Camera/Microphone Usage Check Result:", camMicResult)

    let photoResult = PhotoLibraryUsageAnalyzer.analyze(plist: plist)
    print("27. Photo Library Usage Check Result:", photoResult)

    let results: [String] = [
        "1. ATS Check\n" + atsResult,
        "2. Debug Mode Check\n" + debugResult,
        "3. URL Schemes Check\n" + urlSchemeResult,
        "4. Entitlements Check\n" + entitlementsResult,
        "5. File Sharing Check\n" + fileSharingResult,
        "6. Secrets Scan\n" + secretsResult,
        "7. HTTP URL Scan\n" + httpResult,
        "8. Sensitive Files Check\n" + sensitiveFilesResult,
        "9. Background Modes Check\n" + backgroundModesResult,
        "10. Exit on Suspend Check\n" + exitOnSuspendResult,
        "11. App Size Check\n" + appSizeResult,
        "12. Frameworks Check\n" + frameworksResult,
        "13. ATS Arbitrary Loads Check\n" + arbitraryLoadsResult,
        "14. Persistent WiFi Check\n" + persistentWiFiResult,
        "15. Indirect Input Events Check\n" + indirectInputResult,
        "16. Resource Secrets Check\n" + resourceSecretsResult,
        "17. Binary Strings Check\n" + binaryStringsResult,
        "18. Insecure Network Usage Check\n" + insecureNetworkResult,
        "19. Privacy Permissions Check\n" + privacyPermissionsResult,
        "20. Third-Party SDK Check\n" + sdkResult,
        "21. URL Protocols Check\n" + urlProtocolResult,
        "22. ATS Exceptions Check\n" + atsExceptionsResult,
        "23. Secure Text Entry Check\n" + secureKeyboardResult,
        "24. App Sandbox Check\n" + sandboxResult,
        "25. Location Usage Check\n" + locationUsageResult,
        "26. Camera/Microphone Usage Check\n" + camMicResult,
        "27. Photo Library Usage Check\n" + photoResult
    ]

    let appName = URL(fileURLWithPath: inputPath).lastPathComponent
    ReportGenerator.generateReport(appName: appName, results: results)
    
} else {
    print("Failed to parse Info.plist")
}
