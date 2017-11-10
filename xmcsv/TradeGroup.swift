//
//  TradeGroup.swift
//  xmcsv
//
//  Created by osanai on 2017/11/10.
//  Copyright © 2017年 osanai. All rights reserved.
//

import Cocoa

class TradeGroup: NSObject {
    
    var trades:[Trade] = []
    var title:String = ""
    var date:Date?
    
    func soneki() -> Double {
        var sum:Double = 0.0
        
        for trade in trades {
            sum = sum + trade.soneki!
        }
        
        return Double(sum)
    }
    
    func count() -> Int {
        return trades.count
    }
}
