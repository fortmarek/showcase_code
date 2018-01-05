//
//  CellsInsertableTests.swift
//  CardsTests
//
//  Created by Marek Fořt on 10/13/17.
//  Copyright © 2017 Marek Fořt. All rights reserved.
//

import XCTest
@testable import Elisa
import UIKit

class CellsInsertableTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
    }
    
    func testFindNewIndexPaths() {
        let cellsInsertableObject = CellsInsertableObject()
        let updatedArray: [String] = ["Hello", "Mello"]
        let oldArray: [String] = ["Mello"]
        let newIndexPaths = cellsInsertableObject.findNewIndexPaths(updatedArray: updatedArray, oldArray: oldArray)
        let expectedNewIndexPaths = [IndexPath(row: 0, section: 0)]
        XCTAssertEqual(newIndexPaths, expectedNewIndexPaths)
    }
    
    
}


class CellsInsertableObject: NSObject, CellsInsertable {
    
}
