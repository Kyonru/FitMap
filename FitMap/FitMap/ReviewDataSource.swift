//
//  ReviewDataSource.swift
//  FitMap
//
//  Created by fitmap on 1/13/17.
//  Copyright © 2017 FormuladoresDiscretos. All rights reserved.
//

import Foundation
import LBTAComponents

class ReviewDataSourse: Datasource{
    let Reviews = ["Hola", "Como", "Estas?", "Le", "LLEGUÈ", "MANIN!"]
    
    override func cellClasses() -> [DatasourceCell.Type] {
        return [Cells.self]
    }
    
    override func item(_ indexPath: IndexPath) -> Any? {
        return Reviews[indexPath.item]
    }
    
    override func numberOfItems(_ section: Int) -> Int {
        return Reviews.count
    }
    
    
    
}
