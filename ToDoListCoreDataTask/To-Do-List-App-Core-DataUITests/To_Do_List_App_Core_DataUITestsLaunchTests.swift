//
//  To_Do_List_App_Core_DataUITestsLaunchTests.swift
//  To-Do-List-App-Core-DataUITests
//
//  Created by Isaiah Ojo on 28/04/2023.
//

import XCTest

final class To_Do_List_App_Core_DataUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
