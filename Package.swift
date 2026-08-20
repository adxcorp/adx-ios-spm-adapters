// swift-tools-version:5.7
import PackageDescription

// MARK: - Target Name

private struct TargetName {
    static let coreSupport = "ADXLibraryCoreSupport"
    /// ADX
    static let adx_googleAds = "ADXGoogleAds"
    static let adx_adPie = "ADXAdPie"
    static let adx_appLovin = "ADXAppLovin"
    static let adx_fyber = "ADXFyber"
    static let adx_pangle = "ADXPangle"
    static let adx_unityAds = "ADXUnityAds"
    /// Google Mobile Ads
    static let gad_meta = "GoogleMobileAdsMeta"
}

// MARK: - Product Name

private struct ProductName {
    /// ADX
    static let adx_googleAds = "ADX-GoogleAds"
    static let adx_adPie = "ADX-AdPie"
    static let adx_appLovin = "ADX-AppLovin"
    static let adx_fyber = "ADX-Fyber"
    static let adx_pangle = "ADX-Pangle"
    static let adx_unityAds = "ADX-UnityAds"
    /// Google Mobile Ads
    static let gad_meta = "GoogleMobileAds-Meta"
}

// MARK: - Binary Target Name

private struct BinaryTargetName {
    static let core = "ADXLibraryCoreBinary"
}

// MARK: - Binary Asset

private struct BinaryAsset {
    static let core = "ios/ADXLibrary.xcframework"
}

// MARK: - Repository URL

private struct RepositoryURL {
    static let googleMobileAds = "https://github.com/googleads/swift-package-manager-google-mobile-ads.git"
    static let appLovin = "https://github.com/AppLovin/AppLovin-MAX-Swift-Package.git"
    static let adPie = "https://github.com/gomfactory/AdPie-iOS-SDK.git"
    static let fyber = "https://github.com/inner-active/DTExchangeSDK-iOS-SPM.git"
    static let meta = "https://github.com/googleads/googleads-mobile-ios-mediation-meta"
    static let pangle = "https://github.com/bytedance/AdsGlobalPackage.git"
    static let unityAds = "https://github.com/Unity-Technologies/Unity-Ads-Swift-Package.git"
}

// MARK: - Dependency

private let googleMobileAds: Target.Dependency = .product(name: "GoogleMobileAds", package: "swift-package-manager-google-mobile-ads")
private let appLovin: Target.Dependency = .product(name: "AppLovinSDK", package: "AppLovin-MAX-Swift-Package")
private let adPie: Target.Dependency = .product(name: "spm-adpie-framework", package: "AdPie-iOS-SDK")
private let fyber: Target.Dependency = .product(name: "DTExchangeSDK", package: "DTExchangeSDK-iOS-SPM")
private let metaAdapter: Target.Dependency = .product(name: "MetaAdapterTarget", package: "googleads-mobile-ios-mediation-meta")
private let pangle: Target.Dependency = .product(name: "AdsGlobalPackage", package: "AdsGlobalPackage")
private let unityAds: Target.Dependency = .product(name: "UnityAds", package: "Unity-Ads-Swift-Package")

// MARK: - Support

private func targetDependency(_ name: String) -> Target.Dependency {
    .byName(name: name)
}

private func makeSupportTarget(
    name: String,
    dependencies: [Target.Dependency],
    path: String
) -> Target {
    .target(
        name: name,
        dependencies: dependencies,
        path: path
    )
}

private func makeAdapterTarget(
    name: String,
    dependencies: [Target.Dependency],
    path: String,
    sources: [String]? = nil,
    cSettings: [CSetting]? = nil
) -> Target {
    .target(
        name: name,
        dependencies: dependencies,
        path: path,
        sources: sources,
        publicHeadersPath: "include",
        cSettings: cSettings
    )
}

private func makeBinaryTarget(
    name: String,
    asset: String
) -> Target {
    .binaryTarget(
        name: name,
        path: asset
    )
}

// MARK: - Package

let package = Package(
    name: "ADXLibrary",
    platforms: [.iOS(.v13)],
    products: [
        .library(name: ProductName.adx_googleAds, targets: [TargetName.adx_googleAds]),
        .library(name: ProductName.adx_adPie, targets: [TargetName.adx_adPie]),
        .library(name: ProductName.adx_appLovin, targets: [TargetName.adx_appLovin]),
        .library(name: ProductName.adx_fyber, targets: [TargetName.adx_fyber]),
        .library(name: ProductName.adx_pangle, targets: [TargetName.adx_pangle]),
        .library(name: ProductName.adx_unityAds, targets: [TargetName.adx_unityAds]),
        .library(name: ProductName.gad_meta, targets: [TargetName.gad_meta])
    ],
    dependencies: [
        .package(url: RepositoryURL.googleMobileAds, "12.0.0"..<"14.0.0"),
        .package(url: RepositoryURL.appLovin, .upToNextMajor(from: "13.0.0")),
        .package(url: RepositoryURL.adPie, .upToNextMajor(from: "1.6.9")),
        .package(url: RepositoryURL.fyber, .upToNextMajor(from: "8.3.0")),
        .package(url: RepositoryURL.meta,  .upToNextMinor(from: "6.21.0")),
        .package(url: RepositoryURL.pangle, "7.4.1-release.1"..<"9.0.0"),
        .package(url: RepositoryURL.unityAds, .upToNextMajor(from: "4.15.0"))
    ],
    targets: [
        /// ADAPTER: ADX-Google
        makeAdapterTarget(
            name: TargetName.adx_googleAds,
            dependencies: [targetDependency(TargetName.coreSupport), googleMobileAds],
            path: "ios/adapters/MediationAdapter-AdMob",
            sources: ["AdManagerAdapter/ADX", "AdMobAdapter/ADX"],
            cSettings: [
                .headerSearchPath("AdManagerAdapter/ADX"),
                .headerSearchPath("AdMobAdapter/ADX")
            ]
        ),
        /// ADAPTER: ADX-AdPie
        makeAdapterTarget(
            name: TargetName.adx_adPie,
            dependencies: [targetDependency(TargetName.coreSupport), adPie],
            path: "ios/adapters/MediationAdapter-AdPie",
            sources: ["AdPieAdapter/ADX", "AdPieDirectAd"],
            cSettings: [
                .headerSearchPath("AdPieAdapter/ADX"),
                .headerSearchPath("AdPieDirectAd"),
                .headerSearchPath("AdPieDirectAd/Banner"),
                .headerSearchPath("AdPieDirectAd/Common"),
                .headerSearchPath("AdPieDirectAd/Data"),
                .headerSearchPath("AdPieDirectAd/Data/Response"),
                .headerSearchPath("AdPieDirectAd/Interstitial"),
                .headerSearchPath("AdPieDirectAd/Native"),
                .headerSearchPath("AdPieDirectAd/Rewarded")
            ]
        ),
        /// ADAPTER: ADX-AppLovin
        makeAdapterTarget(
            name: TargetName.adx_appLovin,
            dependencies: [targetDependency(TargetName.coreSupport), appLovin],
            path: "ios/adapters/MediationAdapter-AppLovin/AppLovinAdapter/ADX"
        ),
        /// ADAPTER: ADX-Fyber
        makeAdapterTarget(
            name: TargetName.adx_fyber,
            dependencies: [targetDependency(TargetName.coreSupport), fyber],
            path: "ios/adapters/MediationAdapter-Fyber/FyberAdapter/ADX"
        ),
        /// ADAPTER: ADX-Pangle
        makeAdapterTarget(
            name: TargetName.adx_pangle,
            dependencies: [targetDependency(TargetName.coreSupport), pangle],
            path: "ios/adapters/MediationAdapter-Pangle/PangleAdapter/ADX"
        ),
        /// ADAPTER: ADX-UnityAds
        makeAdapterTarget(
            name: TargetName.adx_unityAds,
            dependencies: [targetDependency(TargetName.coreSupport), unityAds],
            path: "ios/adapters/MediationAdapter-UnityAds/UnityAdsAdapter/ADX"
        ),
        /// ADAPTER: AdMob-Meta
        makeSupportTarget(
            name: TargetName.gad_meta,
            dependencies: [metaAdapter],
            path: "Sources/MetaSPMSupport"
        ),
        /// ADX CORE LIBRARY
        makeSupportTarget(
            name: TargetName.coreSupport,
            dependencies: [targetDependency(BinaryTargetName.core)],
            path: "Sources/ADXLibrarySPMSupport"
        ),
        makeBinaryTarget(
            name: BinaryTargetName.core,
            asset: BinaryAsset.core
        ),
    ]
)
