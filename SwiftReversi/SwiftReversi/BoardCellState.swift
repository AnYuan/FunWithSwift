//
//  BoardCellState.swift
//  SwiftReversi
//
//  Created by Anyuan on 15/2/21.
//  Copyright (c) 2015年 razeware. All rights reserved.
//

import Foundation

enum BoardCellState {
    case Empty, Black, White
    
    func invert() -> BoardCellState {
        if self == Black {
            return White
        } else if self == White {
            return Black
        }
        
        assert(self != self, "cannot invert the empty state")
        return Empty
    }
}