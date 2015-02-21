//
//  SHCReversiBoard.h
//  SHCReversiGame
//
//  Created by Colin Eberhardt on 28/12/2012.
//  Copyright (c) 2012 Colin Eberhardt. All rights reserved.
//

#import "SHCBoard.h"

/** A playing board that board that enforces the rules of the game Reversi. */
@interface SHCReversiBoard : SHCBoard <NSCopying>


// indicates the player who makes the next move
@property (readonly) BoardCellState nextMove;

// Returns whether the player who's turn it is can make the given move
- (BOOL) isValidMoveToColumn:(NSInteger)column andRow:(NSInteger) row;

// Makes the given move for the player who is currently taking their turn
- (void) makeMoveToColumn:(NSInteger) column andRow:(NSInteger)row;


// sets the board to the opening positions for Reversi
- (void) setToInitialState;

// the white player's score
@property (readonly) NSInteger whiteScore;

// the black payer's score
@property (readonly) NSInteger blackScore;

// indicates whether the game has finished
@property (readonly) BOOL gameHasFinished;

// multicasts game state changes
@property (readonly) SHCMulticastDelegate* reversiBoardDelegate;

@end
