//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didCatchData(_ coinData: CoinData)
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "0363E536-3CDB-4613-8DF7-38C8A890B061"
    
    var delegate: CoinManagerDelegate?
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    //Get currency name from main view:
    func currencyURL(for currency: String) {
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        
        performCurrency(urlString)
    }
    
    //Generate the url and get data from thr Internet:
    func performCurrency(_ urlString: String) {
        guard let url = URL(string: urlString) else {return}
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let data = data {
                DispatchQueue.main.async {
                    if let detail = self.fetchData(data: data) {
                        //We get the data from "detail" as CoinData, now we put the got data to a protocol:
                        self.delegate?.didCatchData(detail)
                    }
                }
            } else {
                print(error!.localizedDescription)
            }
            
        }.resume()
    }
    
    //Fetch the data from the above URL:
    func fetchData(data: Data) -> CoinData? {
        
        let decoded = JSONDecoder()
        
        do {
            let details = try decoded.decode(CoinData.self, from: data)
            let name = details.asset_id_quote
            let rate = details.rate
            let lastUpdate = details.time
            
            let result = CoinData(currencyName: name, rate: rate, lastUpdate: lastUpdate)
            return result
        } catch {
            print("There's an error \(error.localizedDescription)")
            return nil
        }
        
    }
    
}
