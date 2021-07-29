//
//  ViewController.swift
//  mCommerce
//
//  Created by Quentin Beaudoul on 28/07/2021.
//

import UIKit

class ProductListController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    private var productViewModel: ProductViewModel!
    private var dataSource: ProductTableViewDataSource<ProductTableViewCell, ProductData>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callToViewModelForUIUpdate()
    }
    
    func callToViewModelForUIUpdate() {
        productViewModel = ProductViewModel()
        productViewModel.bindProductViewModelToController = {
            self.updateDataSource()
        }
    }
    
    func updateDataSource() {
        dataSource = ProductTableViewDataSource(cellIdentifier: "ProductCell", items: productViewModel.productData, configureCell: {
            (cell, product) in
            cell.nameLabelView.text = product.name
            cell.priceLabelView.text = String(product.price) + " €"
            cell.iconImageView.loadImage(withUrl: URL(string: product.image)!)
        })
        DispatchQueue.main.async {
            self.tableView.dataSource = self.dataSource
            self.tableView.reloadData()
        }
    }
}
extension UIImageView {
    func loadImage(withUrl url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let image = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}


