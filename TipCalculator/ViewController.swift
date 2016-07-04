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
        
        
        setupTipControl()
        setupBillField()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        Configuration.saveBillAmount(billField.text!)
    }
    
    func setupTipControl() {
        
        tipControl.removeAllSegments()
        for (index, tipPercentage) in Configuration.tipPercentages.enumerate() {
            tipControl.insertSegmentWithTitle("\(tipPercentage * 100)%", atIndex: index, animated: true)
        }
        
        tipControl.selectedSegmentIndex = Configuration.loadDefaultSelectedRow()
    }
    
    func setupBillField() {
        
        billField.text = Configuration.loadBillAmount()
        onEditingChanged(billField)
        billField.becomeFirstResponder()
        billField.delegate = self
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


extension ViewController: UITextFieldDelegate {
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        let textFieldString = textField.text! as NSString;
        let newString = textFieldString.stringByReplacingCharactersInRange(range, withString:string)
        let floatRegEx = "^([0-9]+)?(\\.([0-9]+)?)?$"
        let floatExPredicate = NSPredicate(format:"SELF MATCHES %@", floatRegEx)
        
        return floatExPredicate.evaluateWithObject(newString)
    }
}
