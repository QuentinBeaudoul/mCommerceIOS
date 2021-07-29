//
//  ProductViewModel.swift
//  mCommerce
//
//  Created by Quentin Beaudoul on 29/07/2021.
//

import Foundation

class ProductViewModel: NSObject {
    
    private var apiService: APIService!
    private(set) var productData: Products! {
        didSet {
            self.bindProductViewModelToController()
        }
    }
    var bindProductViewModelToController : (() -> ()) = {}
    
    override init() {
        super.init()
        self.apiService = APIService()
        callFuncToGetProductData()
    }
    
    func callFuncToGetProductData() {
        self.apiService.apiToGetProductData { (productData) in
            self.productData = productData
        }
    }
}
