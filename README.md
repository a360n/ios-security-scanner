# 🛡️ iOS Security Scanner

**iOS Security Scanner** is a Swift-based command-line tool that scans `.app` and `.ipa` files for common security misconfigurations and privacy risks in iOS applications.  
It automatically generates a human-readable report in both **Markdown** and **PDF** formats.

---

## ✨ Features

- ✅ **27 Static Security Checks** covering entitlements, URL schemes, ATS, hardcoded secrets, insecure networking, and more.
- 📄 **Markdown + PDF Report Generation** with clean formatting.
- 🔍 **No External Dependencies** – fully self-contained.
- 🛠 Written in pure Swift.

---

## 🔍 Supported Checks

| # | Check                             | Description |
|--:|----------------------------------|-------------|
| 1 | ATS Check                        | App Transport Security configuration |
| 2 | Debug Mode                       | Checks for `get-task-allow` |
| 3 | URL Schemes                      | Custom/insecure URL schemes |
| 4 | Entitlements                     | Code signing entitlements |
| 5 | File Sharing                     | `UIFileSharingEnabled` misuse |
| 6 | Hardcoded Secrets                | API keys, tokens in resources |
| 7 | HTTP URLs                        | Insecure `http://` links |
| 8 | Sensitive Files                  | Suspicious files bundled |
| 9 | Background Modes                 | Enabled background services |
|10 | Exit on Suspend                  | Suspends app improperly |
|11 | App Size                         | Size and number of files |
|12 | Embedded Frameworks              | Checks for signed/unsigned frameworks |
|13 | ATS Arbitrary Loads              | Use of `NSAllowsArbitraryLoads` |
|14 | Persistent WiFi                  | Requires constant Wi-Fi? |
|15 | Indirect Input Events            | Checks for indirect input abuse |
|16 | Secrets in Resources             | `.strings` and `.json` secrets |
|17 | Binary Strings                   | Extracts suspicious binary strings |
|18 | Insecure Network Config          | `NSAllowsArbitraryLoadsInWebContent` |
|19 | Privacy Permissions              | Camera, mic, location descriptions |
|20 | Third-party SDKs                 | Known analytics or tracking frameworks |
|21 | URL Protocols                    | Detects unsafe URL types |
|22 | ATS Exceptions                   | Overriding default ATS |
|23 | Secure Text Entry                | Ensures secure password input |
|24 | App Sandbox                      | App sandbox enforcement |
|25 | Location Usage                   | Location privacy compliance |
|26 | Camera / Microphone Usage        | Missing usage descriptions |
|27 | Photo Library Access             | Checks `NSPhotoLibraryUsageDescription` |

---

## 🚀 Usage

```bash
./ios-security-scanner <path_to_.app_or_.ipa>
