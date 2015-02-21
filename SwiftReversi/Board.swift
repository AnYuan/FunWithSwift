//
//  Board.swift
//  SwiftReversi
//
//  Created by Anyuan on 15/2/21.
//  Copyright (c) 2015年 razeware. All rights reserved.
//

import Foundation

class Board {
    private var cells: [BoardCellState]
    let boardSize = 8
    
    init() {
        cells = Array(count: boardSize * boardSize, repeatedValue: BoardCellState.Empty)
    }
    
    func isWithinBounds(location: BoardLocation) -> Bool {
        return location.row >= 0 && location.row < boardSize && location.column >= 0 && location.column < boardSize
    }
    
    subscript(location: BoardLocation) -> BoardCellState {
        get {
            assert(isWithinBounds(location), "row or column index out of bounds")
            return cells[location.row * boardSize + location.column]
        }
        set {
            assert(isWithinBounds(location), "row or column index out of bounds")
            cells[location.row * boardSize + location.column] = newValue
        }
    }
}