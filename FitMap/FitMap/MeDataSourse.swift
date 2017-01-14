//
//  MeDataSourse.swift
//  FitMap
//
//  Created by fitmap on 1/13/17.
//  Copyright © 2017 FormuladoresDiscretos. All rights reserved.
//

import Foundation

import LBTAComponents


class MeDataSourse: Datasource{
    let history = ["Todavia", "Por", "Identificar", "Atun"]
    
    override func cellClasses() -> [DatasourceCell.Type] {
        return [Cells.self]
    }
    
    override func item(_ indexPath: IndexPath) -> Any? {
        return history[indexPath.item]
    }
    
    override func numberOfItems(_ section: Int) -> Int {
        return history.count
    }
    
    
    
}
