//
//  Configuration.swift
//  TipCalculator
//
//  Created by Duy Nguyen on 24/6/16.
//  Copyright © 2016 ZwooMobile Pte. Ltd. All rights reserved.
//

import Foundation

struct Configuration {
    
    static let tipPercentages = [0.18, 0.2, 0.22]
    static let storePercentageKey = "storePercentageKey"
    static let storeBillAmountKey = "storeBillAmountKey"
    
    static func loadDefaultSelectedRow() -> Int{
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        var selectedRow = 0
        if let obj = defaults.objectForKey(Configuration.storePercentageKey) {
            selectedRow = obj as! Int
        }
        return selectedRow
    }
    
    static func saveDefaultSelectedRow(selectedRow: Int) {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(selectedRow, forKey: Configuration.storePercentageKey)
        defaults.synchronize()
    }
    
    static func loadBillAmount() -> String {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        var billAmount = "0"
        if let obj = defaults.objectForKey(Configuration.storeBillAmountKey) {
            billAmount = obj as! String
        }
        return billAmount
    }
    
    static func saveBillAmount(billAmount: String) {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(billAmount, forKey: Configuration.storeBillAmountKey)
        defaults.synchronize()
    }

}