//
//  RandomGridUITests.swift
//  RandomGridUITests
//
//  Created by Wu hung-yi on 2024/4/9.
//

import XCTest

class RandomGridUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testInputRowColumn() throws {
        let app = XCUIApplication()
        app.launch()
        let input = (row: 5, column: 6)
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        let rowTextField = element.children(matching: .textField).matching(identifier: "請輸入大於0的整數").element(boundBy: 0)
        rowTextField.tap()
        rowTextField.typeText("\(input.row)")
        
        let columnTextField = element.children(matching: .textField).matching(identifier: "請輸入大於0的整數").element(boundBy: 1)
        columnTextField.tap()
        columnTextField.typeText("\(input.column)")
        
        app.buttons["確定"].tap()

        let cells = app.collectionViews.cells
        XCTAssertEqual(cells.count, (input.row+1)*input.column, "Grid is not expected as input")
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
