//
//  SHCBoardSquare.h
//  SHCReversiGame
//
//  Created by Colin Eberhardt on 28/12/2012.
//  Copyright (c) 2012 Colin Eberhardt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHCReversiBoard.h"
#import "SHCBoardDelegate.h"

@interface SHCBoardSquare : UIView <SHCBoardDelegate>


- (id) initWithFrame:(CGRect)frame column:(NSInteger)column row:(NSInteger)row board:(SHCReversiBoard*)board;

@end
