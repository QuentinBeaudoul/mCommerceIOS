//
//  APIService.swift
//  mCommerce
//
//  Created by Quentin Beaudoul on 29/07/2021.
//

import Foundation
class APIService: NSObject {
    private let sourcesURL = URL(string: "https://agf.ikomobi.fr/ios-hiring-test/products.json")!
    
    func apiToGetProductData(completion: @escaping (Products) -> ()) {
        URLSession.shared.dataTask(with: sourcesURL) { (data, URLResponse, error) in
            if let data = data {
                let jsonDecoder = JSONDecoder()
                jsonDecoder.userInfo[CodingUserInfoKey.managedObjectContext] = AppDelegate.viewContext
                let productData = try! jsonDecoder.decode(Products.self, from: data)
                completion(productData)
            }
        }.resume()
    }
}
