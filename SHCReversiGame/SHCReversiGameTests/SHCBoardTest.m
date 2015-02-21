//
//  SHCBoardTest.m
//  SHCReversiGame
//
//  Created by Colin Eberhardt on 27/12/2012.
//  Copyright (c) 2012 Colin Eberhardt. All rights reserved.
//

#import "SHCBoardTest.h"
#import "SHCBoard.h"

@implementation SHCBoardTest

- (void)test_setCellState_setWithValidCoords_cellStateIsChanged
{
    SHCBoard* board = [[SHCBoard alloc] init];
    
    // set the state of one of the cells
    [board setCellState:BoardCellStateWhitePiece forColumn:4 andRow:5];
    
    // verify
    BoardCellState retrievedState = [board cellStateAtColumn:4 andRow:5];
    STAssertEquals(BoardCellStateWhitePiece, retrievedState, @"The cell should have been white!");
}

- (void)test_setCellState_setWithInvalidCoords_exceptionWasThrown
{
    SHCBoard* board = [[SHCBoard alloc] init];
    
    @try {
        // set the state of a cell at an invalid coordinate
        [board setCellState:BoardCellStateBlackPiece forColumn:10 andRow:5];
        
        // if an exception was not thrown, this line will be reached
        STFail(@"An exception should have been thrown!");
    }
    @catch (NSException* e) {
        
    }
}

@end
