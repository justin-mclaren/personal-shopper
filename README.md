# AI Shopper Browser

Turn-key SwiftUI + WKWebView browser scaffold powered by Tuist, Swift Package Manager, and Fastlane.

## Repository layout

```
ai-shopper-browser/
├─ Project.swift
├─ Tuist/
│  └─ Config.swift
├─ App/
│  ├─ Sources/
│  │  ├─ AppMain.swift
│  │  ├─ Browser/
│  │  │  ├─ BrowserView.swift
│  │  │  ├─ WebView.swift
│  │  │  ├─ WebViewCoordinator.swift
│  │  │  ├─ ContentRules.swift
│  │  │  └─ UserScripts/
│  │  │     ├─ boot.js
│  │  │     ├─ adapter-loader.js
│  │  │     └─ readability.js
│  │  ├─ AutomationKit/
│  │  │  ├─ AutomationEngine.swift
│  │  │  ├─ SiteAdapter.swift
│  │  │  └─ DOMHelpers.js
│  │  ├─ Storage/
│  │  │  ├─ Database.swift
│  │  │  ├─ Migrations.swift
│  │  │  └─ Models/
│  │  │     ├─ Profile.swift
│  │  │     ├─ Preference.swift
│  │  │     ├─ Product.swift
│  │  │     └─ Vector.swift
│  │  ├─ AIKit/
│  │  │  └─ Embeddings.swift
│  │  ├─ Security/
│  │  │  ├─ KeychainStore.swift
│  │  │  └─ SecretsPolicy.md
│  │  └─ Dev/
│  │     ├─ DevMenu.swift
│  │     └─ Logging.swift
│  ├─ Resources/
│  │  ├─ ContentBlocker.json
│  │  └─ Assets.xcassets
│  └─ Tests/
│     ├─ AppTests/
│     │  └─ AppTests.swift
│     └─ UITests/
│        └─ UITests.swift
├─ Packages/
├─ fastlane/
│  ├─ Fastfile
│  └─ Appfile
├─ Scripts/
│  ├─ make_adapters_bundle.swift
│  ├─ embed_user_scripts.swift
│  ├─ prebuild.sh
│  └─ postbuild.sh
├─ .github/
│  └─ workflows/
│     ├─ ci.yml
│     └─ beta.yml
├─ .gitignore
├─ Package.swift
├─ README.md
└─ LICENSE
```

## Getting started

1. [Install Tuist](https://tuist.io) via Homebrew or the install script.
2. Run `tuist fetch && tuist generate` from the repository root.
3. Open the generated Xcode project and run the **AIShopperBrowser** scheme.

## Continuous Integration

- Pull requests trigger the `iOS CI` workflow which installs Tuist, generates the project, caches dependencies, and runs `fastlane ios test`.
- Tag pushes (e.g., `v1.0.0`) or manual dispatch run the `Beta (TestFlight)` workflow to build and upload via Fastlane using App Store Connect API keys stored in GitHub secrets.

## Fastlane setup

Populate the following repository secrets before running the TestFlight workflow:

- `ASC_KEY_ID`
- `ASC_ISSUER_ID`
- `ASC_KEY_P8`
- `MATCH_PASSWORD`
- `MATCH_GIT_URL`

Signing assets are managed via `fastlane match`. Update the identifiers in `fastlane/Appfile` to match your bundle ID, Apple ID, and team.

## Next steps

- Flesh out the automation engine with real site adapters.
- Replace the placeholder Readability script with the latest upstream source.
- Expand the database models and migrations to capture your product domain.
- Harden the keychain usage with secure enclave and device-local encryption policies.
- Add unit tests and UI tests that cover core shopping flows.
