//
//  ViewController.swift
//  SwiftReversi
//
//  Created by Colin Eberhardt on 07/06/2014.
//  Copyright (c) 2014 razeware. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ReversiBoardDelegate {
                            
  @IBOutlet var blackScore : UILabel!
  @IBOutlet var whiteScore : UILabel!
  @IBOutlet var restartButton : UIButton!
    
    private let board: ReversiBoard
    required init(coder aDecoder: NSCoder) {
        board = ReversiBoard()
        board.setInitialState()
        
        super.init(coder: aDecoder)
        
        board.addDelegate(self)
    }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let boardFrame = CGRect(x: 88, y: 152, width: 600, height: 600)
    let boardView = ReversiBoardView(frame: boardFrame, board: board)
    view.addSubview(boardView)
    boardStateChanged()
    
  }
    
    func boardStateChanged() {
        blackScore.text = "\(board.blackScore)"
        whiteScore.text = "\(board.whiteScore)"
    }
}

