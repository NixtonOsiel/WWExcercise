//
//  WW_Exercise_01UITests.swift
//  WW-Exercise-01UITests
//
//  Created by Paul Newman on 7/13/16.
//  Copyright © 2016 Weight Watchers. All rights reserved.
//

import XCTest

class WW_Exercise_01UITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }

    func testDisplayAlertOnImageViewTap() {
        let app = XCUIApplication()
        XCTAssertEqual(app.alerts.count, 0)
        app.collectionViews.cells.otherElements.containing(.staticText, identifier:"No-Cook").children(matching: .image).element.tap()
        XCTAssertEqual(app.alerts.count, 1)
        app.alerts["Tapped:"].scrollViews.otherElements.buttons["OK"].tap()
        XCTAssertEqual(app.alerts.count, 0)
    }

    func testSearchForFoodListItem() {
        let app = XCUIApplication()
        XCUIApplication().navigationBars["WW_Exercise_01.FoodListView"].searchFields["Search Food"].tap()

        func reset() {
            XCUIApplication().navigationBars["WW_Exercise_01.FoodListView"].searchFields["Search Food"].doubleTap()
            app.keys["delete"].tap()
        }

        XCUIApplication().navigationBars["WW_Exercise_01.FoodListView"].searchFields["Search Food"].typeText("Quick")
        XCTAssertEqual(app.collectionViews.cells.count, 1)
        reset()

        XCUIApplication().navigationBars["WW_Exercise_01.FoodListView"].searchFields["Search Food"].typeText("Italian")
        XCTAssertEqual(app.collectionViews.cells.count, 1)
        reset()

        XCUIApplication().navigationBars["WW_Exercise_01.FoodListView"].searchFields["Search Food"].typeText("")
        XCTAssertEqual(app.collectionViews.cells.count, 8)
        reset()

        XCUIApplication().navigationBars["WW_Exercise_01.FoodListView"].searchFields["Search Food"].typeText("Am")
        XCTAssertEqual(app.collectionViews.cells.count, 2)
        reset()
    }
}
