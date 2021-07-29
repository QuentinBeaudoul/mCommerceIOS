//
//  Product.swift
//  mCommerce
//
//  Created by Quentin Beaudoul on 28/07/2021.
//

import Foundation

struct ProductData: Codable{
    let id: Int
    let name: String
    let price: Double
    let image: String
}

typealias Products = [ProductData]
