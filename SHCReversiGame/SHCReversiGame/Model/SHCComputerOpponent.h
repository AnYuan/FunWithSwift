//
//  SHCComputerOpponent.h
//  SHCReversiGame
//
//  Created by Colin Eberhardt on 02/01/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SHCReversiBoardDelegate.h"
#import "SHCReversiBoard.h"

/** A simple computer opponent. */
@interface SHCComputerOpponent : NSObject<SHCReversiBoardDelegate>

- (id) initWithBoard:(SHCReversiBoard*)board
               color:(BoardCellState)computerColor
            maxDepth:(NSInteger)depth;

@end
