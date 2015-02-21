//
//  SwiftReversiTests.swift
//  SwiftReversiTests
//
//  Created by Colin Eberhardt on 07/06/2014.
//  Copyright (c) 2014 razeware. All rights reserved.
//

import XCTest

class SwiftReversiTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_subscript_setWithValidCoords_cellStateIsChanged() {
        let board = Board()
        
        // set the state of one of the cells
        board[BoardLocation(row: 4, column: 5)] = BoardCellState.White
        
        // verify
        let retrievedState = board[BoardLocation(row: 4, column: 5)];
        XCTAssertEqual(BoardCellState.White, retrievedState, "The cell should have been white!");
    }
    
}
