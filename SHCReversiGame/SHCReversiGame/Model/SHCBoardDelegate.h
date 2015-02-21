//
//  SHCBoardDelegate.h
//  SHCReversiGame
//
//  Created by Colin Eberhardt on 29/12/2012.
//  Copyright (c) 2012 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BoardCellState.h"

@protocol SHCBoardDelegate <NSObject>

- (void)cellStateChanged:(BoardCellState)state forColumn:(int)column andRow:(int) row;

@end
