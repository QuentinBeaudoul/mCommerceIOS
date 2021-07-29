//
//  ProductViewModel.swift
//  mCommerce
//
//  Created by Quentin Beaudoul on 29/07/2021.
//

import Foundation
import CoreData

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
        loadDataFromDataBase()
    }
    
    private func loadDataFromDataBase(){
        let request: NSFetchRequest<ProductData> = ProductData.fetchRequest()
        guard let products = try? AppDelegate.viewContext.fetch(request) else {
            return callFuncToGetProductData()
        }
        if products.count == 0 {
            callFuncToGetProductData()
        }
        self.productData = products
    }
    
    func callFuncToGetProductData() {
        clearDatabase()
        self.apiService.apiToGetProductData { (productData) in
            self.productData = productData
            self.saveToDatabase()
        }
    }
    private func saveToDatabase() {
        try! AppDelegate.viewContext.save()
    }
    private func clearDatabase(){
        let context = AppDelegate.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ProductData")
        do {
            let items = try context.fetch(fetchRequest) as! [NSManagedObject]
            for item in items {
                context.delete(item)
            }
        }catch {
            //TODO
        }
    }
}
