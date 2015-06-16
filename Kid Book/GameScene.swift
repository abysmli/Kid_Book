//
//  GameScene.swift
//  Kid Book
//
//  Created by AbysmLi on 6/15/15.
//  Copyright (c) 2015 AbysmLi. All rights reserved.
//

import SpriteKit

extension Array {
    mutating func shuffle() {
        for i in 0..<(count - 1) {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            swap(&self[i], &self[j])
        }
    }
}

class GameScene: SKScene {
    
    var pages = [[Page?]](count: 6, repeatedValue: [Page?](count: 3, repeatedValue: nil))
    var winLabel:SKLabelNode?
    
    var currentPagenum:[Int] = [ -1, -1, -1 ]
    let pageName:[String] = ["Papagei","Hirsch","Fuchs","Zebra","Rhesusaffe","Eule"]
    
    override func didMoveToView(view: SKView) {
        let frameBeginX = CGRectGetMidX(self.frame)-self.view!.frame.size.width/2+10
        let page_height = self.frame.height * 0.8
        let offsetY = page_height * 0.2 * 1.5
        
        var zIndexsort = [[0,1,2,3,4,5,6],[0,1,2,3,4,5,6],[0,1,2,3,4,5,6]]
        zIndexsort[0].shuffle()
        zIndexsort[1].shuffle()
        zIndexsort[2].shuffle()
        
        for mPagenumber in 1...6 {
            for mPart in 1...3 {
                var part_faktor = 0.4
                var _offset = offsetY
                if (mPart == 2) {
                    part_faktor = 0.2
                    _offset = 0
                } else if (mPart == 3) {
                    _offset = -1 * offsetY
                }
                var _page = Page(imageNamed: "\(mPagenumber)_\(mPart)", size: CGSizeMake(self.view!.frame.size.width, page_height * CGFloat(part_faktor)), zPosition: CGFloat(zIndexsort[mPart-1][mPagenumber-1]), pageNumber: mPagenumber)
                _page.position = CGPointMake(frameBeginX, CGRectGetMidY(self.frame) + _offset)
                self.addChild(_page)
                pages[mPagenumber-1][mPart-1] = _page
                if (zIndexsort[mPart-1][mPagenumber-1] == 0) {
                    currentPagenum[mPart-1] = mPagenumber
                }
            }
        }
        
        winLabel = SKLabelNode(fontNamed:"Gill Sans")
        winLabel!.fontColor = UIColor.brownColor()
        winLabel!.fontSize = 40
        winLabel!.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        winLabel!.zPosition = 100
        self.addChild(winLabel!)
        winLabel!.hidden = true
        
        printCurrentPagenum()
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(self)
            var page:Page? = self.nodeAtPoint(location) as? Page
            page?.turn(page!.zPosition, MaxZIndex: 2)
            winLabel?.hidden = true
            checkSuccess()
        }
    }
    
    func checkSuccess() {
        var pageZindexs:[CGFloat] = [ -1.0, -1.0, -1.0, -1.0, -1.0, -1.0 ]
        
        for _pagepart in 0...2 {
            for _pagenum in 0...5 {
                if (pageZindexs[_pagepart] < pages[_pagenum][_pagepart]!._zPosition && pages[_pagenum][_pagepart]!.turnFlag) {
                    pageZindexs[_pagepart] = pages[_pagenum][_pagepart]!._zPosition
                    currentPagenum[_pagepart] = pages[_pagenum][_pagepart]!.pageNumber
                }
            }
        }
        
        if (currentPagenum[0] == currentPagenum[1] && currentPagenum[1] == currentPagenum[2] && currentPagenum[0] != -1) {
            playSuccessed()
        }
        printCurrentPagenum()
    }
    
    func playSuccessed() {
        winLabel?.text = "Das ist \(pageName[currentPagenum[0]-1])"
        winLabel?.hidden = false
    }
    
    func printCurrentPagenum() {
        println("\(currentPagenum[0]) : \(currentPagenum[1]) : \(currentPagenum[2])")
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
