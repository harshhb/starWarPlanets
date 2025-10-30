//
//  starWarPlanetsUITests.swift
//  starWarPlanetsUITests
//
//  Created by Harshana Ekanayake on 2025-10-29.
//

import XCTest

final class starWarPlanetsUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func launchApp() -> XCUIApplication {
        let app = XCUIApplication()
        app.launchArguments.append("--uitesting")
        app.launch()
        return app
    }

    @MainActor
    func testPlanetListLoads() throws {
        let app = launchApp()
        let firstPlanet = app.staticTexts["Alderaan"]
        let exists = firstPlanet.waitForExistence(timeout: 5)
        XCTAssertTrue(exists, "Planet list did not load successfully")
    }

}
