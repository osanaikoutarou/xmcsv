//
//  Trade.swift
//  xmcsv
//
//  Created by osanai on 2017/11/09.
//  Copyright © 2017年 osanai. All rights reserved.
//

import Cocoa

class Trade: NSObject {
    var tradeID:String?
    var muki:String?
    var symbol:String?
    var lot:Double = 0
    var start:Date?
    var close:Date?
    var sa:Double?
    var pips:Double?
    var soneki:Double?
}
