//
//  CoinData.swift
//  ByteCoin
//
//  Created by Makwan BK on 3/27/20.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import Foundation

struct CoinData: Codable {
    let asset_id_quote: String
    let rate: Double
    let time: String
    
    init(currencyName: String, rate: Double, lastUpdate: String) {
        self.asset_id_quote = currencyName
        self.rate = rate
        self.time = lastUpdate
    }
}
