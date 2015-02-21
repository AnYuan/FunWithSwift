//
//  SHCViewController.m
//  SHCReversiGame
//
//  Created by Colin Eberhardt on 07/12/2012.
//  Copyright (c) 2012 Colin Eberhardt. All rights reserved.
//

#import "SHCViewController.h"
#import "SHCReversiBoard.h"
#import "SHCReversiBoardView.h"
#import "SHCComputerOpponent.h"

@interface SHCViewController ()

@end

@implementation SHCViewController
{
    SHCReversiBoard* _board;
    SHCComputerOpponent* _computer;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // set the various background images
    self.backgroundImage.image = [UIImage imageNamed: @"Reversi.png"];
    self.gameOverImage.image = [UIImage imageNamed: @"GameOver.png"];
    self.gameOverImage.hidden = YES;
    
    // create our game board
    _board = [[SHCReversiBoard alloc] init];
    [_board setToInitialState];
    
    // create a view
    SHCReversiBoardView* reversiBoard = [[SHCReversiBoardView alloc] initWithFrame:CGRectMake(88,151,600,585) andBoard:_board];
    [self.view addSubview:reversiBoard];
    
    [self gameStateChanged];
    [_board.reversiBoardDelegate addDelegate:self];
    
    // add a tap recognizer
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]
                                             initWithTarget:self action:@selector(restartGame:)];
    [self.view addGestureRecognizer:tapRecognizer];
    
    _computer = [[SHCComputerOpponent alloc] initWithBoard:_board
                                                     color:BoardCellStateWhitePiece
                                                  maxDepth:5];
}

- (void)restartGame:(UITapGestureRecognizer*)recognizer
{
    if (_board.gameHasFinished)
    {
        [_board setToInitialState];
        [self gameStateChanged];
    }
}

- (void)gameStateChanged
{
    _gameOverImage.hidden = !_board.gameHasFinished;
    _whiteScore.text = [NSString stringWithFormat:@"%d", _board.whiteScore];
    _blackScore.text = [NSString stringWithFormat:@"%d", _board.blackScore];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
