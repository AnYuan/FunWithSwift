//
//  BoardSquare.swift
//  SwiftReversi
//
//  Created by Anyuan on 15/3/1.
//  Copyright (c) 2015年 razeware. All rights reserved.
//

import Foundation
import UIKit

class BoardSquare: UIView, BoardDelegate {
    private let board: ReversiBoard
    private let location: BoardLocation
    private let blackView: UIImageView
    private let whiteView: UIImageView
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(frame: CGRect, location: BoardLocation, board: ReversiBoard) {
        self.board = board
        self.location = location
        
        let blackImage = UIImage(named: "ReversiBlackPiece.png")
        blackView = UIImageView(image: blackImage)
        blackView.alpha = 0
        
        let whiteImage = UIImage(named: "ReversiWhitePiece.png")
        whiteView = UIImageView(image: whiteImage)
        whiteView.alpha = 0
        
        super.init(frame: frame)
        
        backgroundColor = UIColor.clearColor()
        
        addSubview(blackView)
        addSubview(whiteView)
        
        update()
        
        board.addDelegate(self)
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: "cellTapped")
        addGestureRecognizer(tapRecognizer)
    }
    
    private func update() {
        let state = board[location]
        
        UIView.animateWithDuration(0.2, animations: {
            
            switch state {
            case .White:
                self.whiteView.alpha = 1.0
                self.blackView.alpha = 0.0
                self.whiteView.transform = CGAffineTransformIdentity
                self.blackView.transform = CGAffineTransformMakeTranslation(0, 20)
            case .Black:
                self.whiteView.alpha = 0.0
                self.blackView.alpha = 1.0
                self.whiteView.transform = CGAffineTransformMakeTranslation(0, -20)
                self.blackView.transform = CGAffineTransformIdentity
            case .Empty:
                self.whiteView.alpha = 0.0
                self.blackView.alpha = 0.0
            }
        })
        
    }
    
    func cellTapped() {
        if board.isValidMove(location) {
            board.makeMove(location)
        }
    }
    
    func cellStateChanged(location: BoardLocation) {
        if self.location == location {
            update()
        }
    }
}