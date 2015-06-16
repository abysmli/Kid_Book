//
//  page.swift
//  Kid Book
//
//  Created by AbysmLi on 6/15/15.
//  Copyright (c) 2015 AbysmLi. All rights reserved.
//

import Foundation
import SpriteKit

class Page: SKSpriteNode {
    
    var turnFlag:Bool = true
    var pageNumber:Int = 0
    var _zPosition:CGFloat = 0
    
    init(imageNamed: String, size: CGSize, zPosition: CGFloat, pageNumber: Int) {
        let imageTexture = SKTexture(imageNamed: imageNamed)
        super.init(texture: imageTexture, color: nil, size: size)
        self.anchorPoint = CGPointMake(0, 0.5)
        self.zPosition = zPosition
        self._zPosition = zPosition
        self.pageNumber = pageNumber
    }
    
    func turn(currentZIndex:CGFloat, MaxZIndex:CGFloat) {
        if (turnFlag) {
            self.change_ZIndex(currentZIndex, MaxZIndex:MaxZIndex)
            self.runAction(SKAction.scaleXTo(-1.0, duration: 0.5), completion: {self.changeZIndex(currentZIndex, MaxZIndex:MaxZIndex)})
            turnFlag = false;
        } else {
            self.change_ZIndex(currentZIndex, MaxZIndex:MaxZIndex)
            self.changeZIndex(currentZIndex, MaxZIndex:MaxZIndex)
            self.runAction(SKAction.scaleXTo(1.0, duration: 0.5))
            turnFlag = true;
        }
    }
    
    func changeZIndex(currentZIndex:CGFloat, MaxZIndex:CGFloat) {
        self.zPosition = MaxZIndex - currentZIndex;
    }
    
    func change_ZIndex(currentZIndex:CGFloat, MaxZIndex:CGFloat) {
        self._zPosition = MaxZIndex - currentZIndex;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}