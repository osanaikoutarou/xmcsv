//
//  ViewController.swift
//  xmcsv
//
//  Created by osanai on 2017/11/09.
//  Copyright © 2017年 osanai. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        CsvManager().op()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

