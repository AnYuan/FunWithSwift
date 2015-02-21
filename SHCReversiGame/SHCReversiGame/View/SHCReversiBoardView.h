//
//  SHCReversiBoardView.h
//  SHCReversiGame
//
//  Created by Colin Eberhardt on 28/12/2012.
//  Copyright (c) 2012 Colin Eberhardt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHCReversiBoard.h"

/** A view which renders the Reversi board */
@interface SHCReversiBoardView : UIView

- (id)initWithFrame:(CGRect)frame andBoard:(SHCReversiBoard*) board;

@end
