//
//  ViewController.swift
//  TipCalculator
//
//  Created by Duy Nguyen on 27/8/16.
//  Copyright © 2016 ZwooMobile Pte. Ltd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        
        var index = 0
        tipControl.removeAllSegments()
        for var tipPercentage in Configuration.tipPercentages {
            tipPercentage *= 100
            tipControl.insertSegmentWithTitle("\(tipPercentage)%", atIndex: index, animated: true)
            index += 1
        }
        
        tipControl.selectedSegmentIndex = Configuration.loadDefaultSelectedRow()
        billField.text = Configuration.loadBillAmount()
        onEditingChanged(billField)
        billField.becomeFirstResponder()
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)

        Configuration.saveBillAmount(billField.text!)
    }

    @IBAction func onEditingChanged(sender: AnyObject) {
        
        let tipPercentage = Configuration.tipPercentages[tipControl.selectedSegmentIndex]
        
        let billAmount = NSString(string: billField.text!).doubleValue
        let tip = billAmount * tipPercentage
        let total = billAmount + tip
        
        tipLabel.text = convertCurrency(tip)
        totalLabel.text = convertCurrency(total)

        if total > 0 {
            UIView.animateWithDuration(0.3, animations: {
                self.totalLabel.transform = CGAffineTransformScale(self.totalLabel.transform, 2, 2)
                self.totalLabel.textColor = UIColor.redColor()
            }) { (true) in
                UIView.animateWithDuration(0.1, animations: {
                    self.totalLabel.transform = CGAffineTransformIdentity
                    self.totalLabel.textColor = UIColor.blackColor()
                })
            }
        }
        
    }

    @IBAction func onTapped(sender: AnyObject) {
        
        view.endEditing(true)
    }
    
    func convertCurrency(number: NSNumber) -> String? {
        
        let formatter = NSNumberFormatter.init()
        formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        formatter.currencySymbol = "$"
        
        return formatter.stringFromNumber(number)
    }
}

