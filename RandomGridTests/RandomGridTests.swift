//
//  RandomGridTests.swift
//  RandomGridTests
//
//  Created by Wu hung-yi on 2024/4/9.
//

import XCTest
@testable import RandomGrid

class RandomGridTests: XCTestCase {

    var viewModel: GridViewModel!
    
    override func setUpWithError() throws {
        viewModel = GridViewModel(row: 3, column: 4)
    }

    func testNewElement() throws {
        let input = (row: 5, column: 6)
        viewModel.setupInput(row: input.row, column: input.column)
        let selected = viewModel.selectedIndex
        let result = viewModel.emitNewElement()
        let expected = newElementExpected(input: input, selectedIndex: selected)
        XCTAssertEqual(result, expected, "emitNewElement is not expected")
    }
    
    func newElementExpected(input: (row: Int, column: Int), selectedIndex: CGPoint) -> Array<CustomSectionDataType> {
        let inputRow = input.row
        let inputColumm = input.column
        let row = inputRow + 1
        var _columns: [CustomSectionDataType] = []
        for c in 0..<inputColumm {
            var _row = Array.init(repeating: CollectionData(), count: row)
            for r in 0..<row {
                let selected = r == Int(selectedIndex.x) && c == Int(selectedIndex.y)
                let id = "\(c)+\(r)"
                if r == row-1 {
                    _row[r] = CollectionData(id: id, isSelected: false, rowCount: inputRow, columnCount: inputColumm, dataType: RowDataType.buttnCell)
                } else {
                    _row[r] = CollectionData(id: id, isSelected: selected, rowCount: inputRow, columnCount: inputColumm, dataType: RowDataType.randomCell)
                }
                if c == Int(selectedIndex.y) {
                    _row[r].columnSelected = true
                }
            }
            _columns.append(CustomSectionDataType(model: "\(c)", items: _row))
        }
        return _columns
    }

}
