//
//  CollectionData.swift
//  RandomGrid
//
//  Created by Wu hung-yi on 2024/4/9.
//  Copyright © 2024 Wu. All rights reserved.
//

import RxDataSources

enum RowDataType {
    case randomCell, buttnCell
}
struct CollectionData: IdentifiableType, Equatable {
    
    let id: String
    var isSelected: Bool
    var columnSelected: Bool
    var rowCount: Int
    var columnCount: Int
    var dataType: RowDataType
    
    typealias Identity = String
    
    var identity: Identity {
        return id
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id &&
            lhs.isSelected == rhs.isSelected &&
            lhs.columnSelected == rhs.columnSelected &&
            lhs.dataType == rhs.dataType
    }
    
    init(id: String = "0", isSelected: Bool = false, rowCount: Int = 0, columnCount: Int = 0, dataType: RowDataType = .buttnCell) {
        self.id = id
        self.isSelected = isSelected
        self.rowCount = rowCount
        self.columnCount = columnCount
        self.dataType = dataType
        self.columnSelected = false
    }
}

typealias CustomSectionDataType = AnimatableSectionModel<String,CollectionData>
