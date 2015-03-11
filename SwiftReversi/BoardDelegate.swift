//
//  BoardDelegate.swift
//  SwiftReversi
//
//  Created by Anyuan on 15/3/1.
//  Copyright (c) 2015年 razeware. All rights reserved.
//

import Foundation

protocol BoardDelegate {
    func cellStateChanged(location: BoardLocation)
}