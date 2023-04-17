//
//  ProductsTableViewController.swift
//  StoreApp
//
//  Created by Asadullah Behlim on 14/04/23.
//

import Foundation
import UIKit
import SwiftUI

class ProductsTableViewController : UITableViewController {
    private var category: CategoryModel
    private var products : [ProductModel] = []
    private var client = StoreHTTPClient()
    
    init(category: CategoryModel) {
        self.category = category
        super.init(nibName: nil, bundle: nil)
    }
    
    lazy var addProductBarButtonItem:UIBarButtonItem = {
        
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addProductButtonPressed))
        return barButtonItem
    }()
    
    @objc private func addProductButtonPressed(_ sender: UIBarButtonItem) {
        let addProductVC = AddProductViewController()
        let navCtrl = UINavigationController(rootViewController: addProductVC)
        present(navCtrl, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = category.name
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ProductTableViewCell")
        navigationItem.rightBarButtonItem = addProductBarButtonItem
        
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
        cell.contentConfiguration = UIHostingConfiguration(content: {
            ProductCellView(product: product)
        })
        return cell
    }
}
