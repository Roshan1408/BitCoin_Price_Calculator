//
//  BitCionManager.swift
//  Bitcoin_Price_Calculator
//
//  Created by Roshan on 10/01/25.
//

import Foundation
import UIKit

protocol DataPass
{
    func dataPass(rate: String)
}
struct BitCionManager
{
    let url="https://rest.coinapi.io/v1/exchangerate/BTC/"
    let api_Key="30356451-2B3C-4443-9088-BF275E8BDB37"
    var delegate: DataPass!
    
    func getCoinPrice(coinCurrency: String)
    {
        let url=url+coinCurrency+"?apiKey=\(api_Key)"
        print(url)
        performRequest(urlString: url)
    }
    
    func performRequest(urlString: String)
    {
        if let url=URL(string: urlString)
        {
            let session=URLSession(configuration: .default)
            
            let task=session.dataTask(with: url, completionHandler: handle(data:response:error:))
            
            task.resume()
        }
    }
    func handle(data: Data?, response: URLResponse?, error: Error?)
    {
        if error != nil
        {
            print(error!)
            return
        }
        
        if let safeData=data
        {
            parseJSON(pricedata: safeData)
        }
    }
    
    func parseJSON(pricedata: Data)
    {
        let decoder=JSONDecoder()
        
        do{
           let decodedData = try decoder.decode(BitCoinModel.self, from: pricedata)
            let rate=String(format: "%.2f", decodedData.rate)
            
            delegate.dataPass(rate: rate)
        }
        catch{
            print(error)
        }
    }
}
