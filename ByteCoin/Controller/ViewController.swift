//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, CoinManagerDelegate {
    
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var lastUpdateLabel: UILabel!
    
    @IBOutlet weak var picker: UIPickerView!
    
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Background gradiend color:
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [UIColor(red:0.51, green:0.64, blue:0.83, alpha:1.00).cgColor, UIColor(red:0.71, green:0.98, blue:1.00, alpha:1.00).cgColor]
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        
        picker.delegate = self
        picker.dataSource = self
        
        coinManager.delegate = self
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let currency = coinManager.currencyArray[row]
        
        coinManager.currencyURL(for: currency)
    }
    
    func didCatchData(_ coinData: CoinData) {
        currencyLabel.text = coinData.asset_id_quote
        bitcoinLabel.text = String(format: "%.2f", coinData.rate)
        lastUpdateLabel.text = "Last Update: \(coinData.time.replacingMultipleOccurrences(using: (of: "T", with: " "), (of: "Z", with: " UTC +0")))"

    }
    
}

