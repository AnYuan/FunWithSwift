//
//  BoardCellState.h
//  SHCReversiGame
//
//  Created by Colin Eberhardt on 27/12/2012.
//  Copyright (c) 2012 Colin Eberhardt. All rights reserved.
//

#ifndef SHCReversiGame_BoardCellState_h
#define SHCReversiGame_BoardCellState_h

typedef NS_ENUM(NSUInteger, BoardCellState) {
    BoardCellStateEmpty = 0,
    BoardCellStateBlackPiece = 1,
    BoardCellStateWhitePiece = 2
};

#endif
