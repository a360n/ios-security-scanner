# 🔍 iOS Security Scanner

A powerful, open-source Swift-based tool that performs static security analysis on iOS app packages (`.app` or `.ipa`).  
Designed to help iOS developers, security engineers, and mobile testers identify insecure configurations, privacy violations, and risky practices **before release**.

---

##  Project Goal

`iOS Security Scanner` was built to automate the detection of common security issues in iOS apps by scanning their structure, metadata, and resources — with **zero execution required**.

---

##  Core Components

###  Static Analysis
- Parses `Info.plist`, entitlements, and app metadata
- Extracts secrets from `.plist`, `.json`, `.strings`, and binary files
- Flags insecure configurations or suspicious behaviors

###  .app & .ipa Support
- Automatically unzips `.ipa` packages
- Analyzes both development (`.app`) and distribution builds

###  Report Generation
- Detailed Markdown report with risk summaries
- Auto-generated PDF version for printing/sharing

---

##  Supported Security Checks (27)

|  Check |  Description |
|---------|----------------|
| ATS Configuration | Verifies `NSAppTransportSecurity` policies |
| Debug Mode | Checks if `get-task-allow` is enabled |
| URL Schemes | Detects unprotected or custom schemes |
| Entitlements | Analyzes code signature and sandbox status |
| File Sharing | Flags `UIFileSharingEnabled` misuse |
| Hardcoded Secrets | Scans for API keys or sensitive strings |
| HTTP URLs | Detects non-encrypted links |
| Sensitive Files | Lists any exposed/unused internal files |
| Background Modes | Checks declared services |
| Exit on Suspend | Flags if the app exits when suspended |
| App Size | Calculates app size and file count |
| Embedded Frameworks | Inspects included third-party libraries |
| Arbitrary Loads | Checks for `NSAllowsArbitraryLoads` usage |
| Persistent WiFi | Looks for `UIRequiresPersistentWiFi` |
| Indirect Input Events | Validates `UIApplicationSupportsIndirectInputEvents` |
| Resource Secrets | Scans `.json`, `.plist`, `.strings` for secrets |
| Binary Strings | Extracts readable strings from binaries |
| Insecure WebContent ATS | Verifies `NSAllowsArbitraryLoadsInWebContent` |
| Privacy Permissions | Inspects camera, mic, location access |
| SDK Tracking | Detects analytics/3rd-party SDKs |
| Unsafe URL Protocols | Finds use of insecure URL schemes |
| ATS Exceptions | Lists any ATS overrides or exceptions |
| Secure Text Entry | Flags sensitive inputs without `secureTextEntry` |
| App Sandbox | Confirms proper sandboxing is enforced |
| Location Usage Descriptions | Verifies `NSLocationWhenInUseUsageDescription` |
| Camera / Mic Usage | Checks justification for usage permissions |
| Photo Library Access | Inspects access to `NSPhotoLibraryUsageDescription` |

---

##  Example Report

> Sample report files are located in the [`/Reports/`](./Reports/) directory.

- `SecurityReport.md`
- `SecurityReport.pdf`


##  License

This project is licensed under the [MIT License](./LICENSE).  
Feel free to use, modify, and distribute it with proper attribution.

---

## Author

**Ali Nasser**  
Secure Mobile App Developer · Application Security Specialist · iOS Security Enthusiast  

- [GitHub](https://github.com/a360n)  
-  [LinkedIn](https://www.linkedin.com/in/ali-nasser-dev)

