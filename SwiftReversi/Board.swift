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
    
    subscript(row: Int, column: Int) -> BoardCellState {
        get {
            return self[BoardLocation(row: row, column: column)]
        }
        set {
            self[BoardLocation(row: row, column: column)] = newValue
        }
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
    
    // a visitor, where the supplied closure is applied to each cell
    // visitor pattern : http://en.wikipedia.org/wiki/Visitor_pattern
    func cellVisitor(fn: (BoardLocation) ->()) {
        for column in 0..<boardSize {
            for row in 0..<boardSize {
                let location = BoardLocation(row: row, column: column)
                fn(location)
            }
        }
    }
    
    func clearBoard() {
        cellVisitor {self[$0] = .Empty}
    }

}