//
//  GridViewModel.swift
//  RandomGrid
//
//  Created by Wu hung-yi on 2024/4/9.
//  Copyright © 2024 Wu. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class GridViewModel {
    
    var inputColumm: Int = 3
    var inputRow: Int = 4
    var timer: Timer?
    var selectedIndex: CGPoint = .zero
    var disposeBag = DisposeBag()
    
    let updateTimeInterval: TimeInterval = 10
    let collectionCellMinimumLineSpacing: CGFloat = 0
    let rowSource = PublishSubject<[CustomSectionDataType]>()
    var resetDidClick = PublishRelay<Void>()
    
    var row: Int {
        return inputRow + 1
    }
    
    init(row: Int, column: Int) {
        self.inputRow = row
        self.inputColumm = column
        resetDidClick.subscribe(onNext: {[unowned self] in
            self.selectedIndex = CGPoint(x: -1, y: -1)
            rowSource.onNext(emitNewElement())
        }).disposed(by: disposeBag)
    }
    
    deinit {
        timer?.invalidate()
        disposeBag = DisposeBag()
    }
    
    func setupInput(row: Int, column: Int) {
        inputRow = row
        inputColumm = column
        getRandomValue()
        rowSource.onNext(emitNewElement())
        timer = Timer.scheduledTimer(withTimeInterval: updateTimeInterval, repeats: true) { [weak self] _ in
            guard let self = self else {return}
            self.getRandomValue()
            self.rowSource.onNext(self.emitNewElement())
        }
    }
    
    func emitNewElement() -> Array<CustomSectionDataType> {
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
        print("selectedIndex:",selectedIndex)
        return _columns
    }
    
    func getRandomValue() {
        let randomX = Int.random(in: 0...inputRow-1)
        let randomY = Int.random(in: 0...inputColumm-1)
        selectedIndex = CGPoint(x: randomX, y: randomY)
    }
    
}
