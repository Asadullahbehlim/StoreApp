//
//  ProductsTableViewController.swift
//  StoreApp
//
//  Created by Asadullah Behlim on 14/04/23.
//

import Foundation
import UIKit

class ProductsTableViewController : UITableViewController {
    private var category: CategoryModel
    private var products : [ProductModel] = []
    private var client = StoreHTTPClient()
    
    init(category: CategoryModel) {
        self.category = category
        super.init(nibName: nil, bundle: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = category.name
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ProductTableViewCell")
        
        
        Task {
            await populateProducts()
        }
    }
    
    private func populateProducts() async {
        do {
            products = try await client.getProductsByCategory(categoryId: category.id)
            tableView.reloadData()
        }
        catch {
            print(error)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        products.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath)
        
        let product = products[indexPath.row]
        var configuration = cell.defaultContentConfiguration()
        configuration.text = product.title
        configuration.secondaryText = product.description
        cell.contentConfiguration = configuration
        return cell
    }
}
