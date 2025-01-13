//
//  ViewController.swift
//  Bitcoin_Price_Calculator
//
//  Created by Roshan on 10/01/25.
//

import UIKit

class ViewController: UIViewController
{
    
    @IBOutlet weak var currencyPicker: UIPickerView!
    @IBOutlet weak var bitCoinCurrency: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyRoundedStackView: UIStackView!
    
    @IBOutlet weak var cornerRadiusButton: UIButton!
    var bitCoinManager=BitCionManager()
    
    let currencyArray=[
         "EUR", "USD", "JPY", "GBP", "INR", "AUD", "CAD", "CHF", "CNY", "BRL", "ZAR", "SAR", "KRW", "TRY", "MXN", "SGD", "HKD", "NZD", "NOK"
    ]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        currencyPicker.isHidden=true
        currencyPicker.layer.cornerRadius=15
        currencyPicker.layer.borderWidth=2
        currencyPicker.layer.borderColor=UIColor.white.cgColor
        currencyPicker.delegate=self
        currencyPicker.dataSource=self
        bitCoinManager.delegate=self
        
        currencyRoundedStackView.layer.cornerRadius = 15
        currencyRoundedStackView.layer.borderWidth = 2
        currencyRoundedStackView.layer.borderColor = UIColor.white.cgColor
        
        cornerRadiusButton.layer.cornerRadius = 15
        cornerRadiusButton.layer.borderWidth = 2
        cornerRadiusButton.layer.borderColor = UIColor.white.cgColor
    }
    @IBAction func currencyButtonPressed(_ sender: UIButton)
    {
        currencyPicker.isHidden=false
        callAPI(0)
    }
}



extension ViewController: UIPickerViewDelegate,UIPickerViewDataSource
{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyArray.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyArray[row]
    }
    
    fileprivate func callAPI(_ row: Int) {
        let selectedCurrency=currencyArray[row]
        bitCoinCurrency.text=selectedCurrency
        
        bitCoinManager.getCoinPrice(coinCurrency: selectedCurrency)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        callAPI(row)
    }
}

extension ViewController: DataPass
{
    func dataPass(rate: String)
    {
        DispatchQueue.main.async
        {
            self.currencyLabel.text=rate
        }
    }
}
