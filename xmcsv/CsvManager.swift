//
//  CsvManager.swift
//  xmcsv
//
//  Created by osanai on 2017/11/09.
//  Copyright © 2017年 osanai. All rights reserved.
//

import Cocoa

class CsvManager: NSObject {
    
    var tradeDatas:[Trade] = []
    var tradeGroupDay:[TradeGroup] = []
    
    func csv(data: String) -> [[String]] {
        var result: [[String]] = []
        let rows = data.components(separatedBy: "\r\n")
        for row in rows {
            let columns = row.components(separatedBy: ",")
            
            result.append(columns)
        }
        return result
    }
    
    func op() {
        let file = "rirekiall.csv"
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            let fileURL = dir.appendingPathComponent(file)
            
//            //writing
//            do {
//                try text.write(to: fileURL, atomically: false, encoding: .utf8)
//            }
//            catch {/* error handling here */}
            
            //reading
            do {
                let text2 = try String(contentsOf: fileURL, encoding: .utf8)
                
                let c = csv(data: text2)
                
                for data in c {
                    if data.first == "注文" {
                        continue
                    }
                    let trade = Trade()
                    trade.tradeID = data[0]
                    trade.muki = data[1]
                    trade.symbol = data[2]
                    trade.lot = Double(data[3])!
                    trade.start = getDate(s: data[4])
                    trade.close = getDate(s: data[8])
                    trade.sa = (Double(data[9])! - Double(data[5])!)
                    if trade.muki == "sell" {
                        if let d = trade.sa {
                            trade.sa = d * -1
                        }
                    }
                    trade.soneki = Double(data[12])
                    
                    tradeDatas.append(trade)
                }
                
                var count:Int = 0
                for trade in tradeDatas {
                    
                    if tradeGroupDay.isEmpty {
                        let tradeGroup = TradeGroup()
                        tradeGroup.date = trade.start
                        tradeGroup.trades.append(trade)
                        tradeGroupDay.append(tradeGroup)
                        
                        continue
                    }
                    
                    let tradeGroup = tradeGroupDay.last
                    
                    var sameDay = false
                    // これが上手く出てない
                    sameDay = Calendar.current.isDate(trade.start!,
                                                      equalTo: (tradeGroup?.date)!,
                                                      toGranularity: .day)
                    if sameDay {
                        tradeGroup?.trades.append(trade)
                    }
                    else {
                        // 新規day
                        let newTradeGroup = TradeGroup()
                        newTradeGroup.date = trade.start
                        newTradeGroup.trades.append(trade)
                        tradeGroupDay.append(newTradeGroup)
                    }
                    
                    if count % 1000 == 0 {
                        print(count)
                    }
                    count += 1
                }
                
                for tradeGroup in tradeGroupDay {
                    print(tradeGroup.date ?? "nil")
                    print(tradeGroup.soneki())
                    print(tradeGroup.trades.count)
                }
                
                print(tradeDatas.count)
            }
            catch {
                /* error handling here */
                print("きゃっち")
            }
        }
    }
    
    func getDate(s:String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd HH:mm" //Your date format
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+00:00") //Current time zone
        let date = dateFormatter.date(from: s) //according to date format your date string
        return date!
    }
}
