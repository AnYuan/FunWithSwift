//
//  ReversiBoard.swift
//  SwiftReversi
//
//  Created by Anyuan on 15/3/1.
//  Copyright (c) 2015年 razeware. All rights reserved.
//

import Foundation
class ReversiBoard: Board {
    private (set) var blackScore = 0, whiteScore = 0
    private (set) var nextMove = BoardCellState.White
    
    func setInitialState() {
        
        clearBoard()
        
        super[3,3] = .White
        super[4,4] = .White
        super[3,4] = .Black
        super[4,3] = .Black
        
        blackScore = 2
        whiteScore = 2
    }
    
    func isValidMove(location: BoardLocation) -> Bool {
        return self[location] == BoardCellState.Empty
    }
    
    func makeMove(location: BoardLocation) {
        self[location] = nextMove
        nextMove = nextMove.invert()
    }
}