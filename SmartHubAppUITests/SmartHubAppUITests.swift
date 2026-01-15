//
//  SmartHubAppUITests.swift
//  SmartHubAppUITests
//
//  Created by chun wai wong on 13/1/2026.
//

import XCTest

final class SmartHubAppUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    // ✅ 測試 App 能正常啟動
    @MainActor
    func testAppLaunch() throws {
        let app = XCUIApplication()
        app.launch()
        XCTAssertTrue(app.waitForExistence(timeout: 5.0), "🚀 App 應該可以成功啟動")
    }

    // ⚡ 檢查 App 啟動性能
    @MainActor
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                let app = XCUIApplication()
                app.launch()
            }
        }
    }
}
