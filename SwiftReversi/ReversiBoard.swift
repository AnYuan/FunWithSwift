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
    private let reversiBoardDelegates = DelegateMulticast<ReversiBoardDelegate>()
    
    func setInitialState() {
        
        clearBoard()
        
        super[3,3] = .White
        super[4,4] = .White
        super[3,4] = .Black
        super[4,3] = .Black
        
        blackScore = 2
        whiteScore = 2
    }
    
    func addDelegate(delegate: ReversiBoardDelegate) {
        reversiBoardDelegates.addDelegate(delegate)
    }
    
    func isValidMove(location: BoardLocation) -> Bool {
        return isValidMove(location, toState: nextMove)
    }
    
    private func isValidMove(location: BoardLocation, toState: BoardCellState) -> Bool {
        // check the cell is empty
        if self[location] != BoardCellState.Empty {
            return false
        }
        
        // test whether the move surrounds any of the opponents pieces
        for direction in MoveDirection.directions {
            if moveSurroundsCounters(location, direction: direction, toState: toState) {
                return true
            }
        }
        return false
    }
    
    private func flipOpponentsCounters(location: BoardLocation, direction: MoveDirection, toState: BoardCellState) {
        //is this a valid move?
        if !moveSurroundsCounters(location, direction: direction, toState: toState) {
            return
        }
        
        let opponentsState = toState.invert()
        var currentState = BoardCellState.Empty
        var currentLocation = location
        
        //flip counters until the edge of the board is reached or 
        //a piece with the current state is reached
        do {
            currentLocation = direction.move(currentLocation)
            currentState = self[currentLocation]
            self[currentLocation] = toState
        }while (isWithinBounds(currentLocation) && currentState == opponentsState)
    }
    
    func makeMove(location: BoardLocation) {
        self[location] = nextMove
        
        for direction in MoveDirection.directions {
            flipOpponentsCounters(location, direction: direction, toState: nextMove)
        }
        
        nextMove = nextMove.invert()
        
        whiteScore = countMatches { self[$0] == BoardCellState.White }
        blackScore = countMatches { self[$0] == BoardCellState.Black }
        
        reversiBoardDelegates.invokeDelegates{$0.boardStateChanged()}
    }
    
    //This method determines wether a move to a specific location on the board
    //would surround one or more of the opponent's pieces. Within the while loop, the code checks the required conditions:
    //0)the neighboring cell must be occupied by a piece of the opposing color
    //1)the following cell is the opposing color, in which case the while loop continues
    //2)the following cell is the player's color, which means a group is surrounded
    func moveSurroundsCounters(location: BoardLocation, direction: MoveDirection, toState: BoardCellState) -> Bool {
        var index = 1
        var currentLocation = direction.move(location)
        
        while isWithinBounds(currentLocation) {
            let currentState = self[currentLocation]
            if index == 1 {
                //Immediate neighbors must be the opponent's color
                if currentState != toState.invert() {
                    return false
                }
            }
            else {
                //if the player's color is reached, the move is valid
                if currentState == toState {
                    return true
                }
                
                //if an empty cell is reached give up!
                if currentState == BoardCellState.Empty {
                    return false
                }
            }
            index++
            
            //move to the next cell
            currentLocation = direction.move(currentLocation)
        }
        return false
    }
}