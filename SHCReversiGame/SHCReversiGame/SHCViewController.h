//
//  SHCViewController.h
//  SHCReversiGame
//
//  Created by Colin Eberhardt on 07/12/2012.
//  Copyright (c) 2012 Colin Eberhardt. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SHCReversiBoardDelegate.h"

@interface SHCViewController : UIViewController <SHCReversiBoardDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UILabel *blackScore;
@property (weak, nonatomic) IBOutlet UILabel *whiteScore;
@property (weak, nonatomic) IBOutlet UIImageView *gameOverImage;

@end
