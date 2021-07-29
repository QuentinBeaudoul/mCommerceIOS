//
//  ProductTableViewDataSource.swift
//  mCommerce
//
//  Created by Quentin Beaudoul on 29/07/2021.
//

import UIKit

class ProductTableViewDataSource<CELL : ProductTableViewCell, T>: NSObject, UITableViewDataSource {
    
    private var cellIdentifier: String!
    private var items : [T]!
    var configureCell: (CELL, T) -> () = {_, _ in }

    init(cellIdentifier: String, items: [T], configureCell: @escaping (CELL, T) -> ()) {
        self.cellIdentifier = cellIdentifier
        self.items = items
        self.configureCell = configureCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CELL
        let item = items[indexPath.row]
        configureCell(cell, item)
        return cell
    }
}
