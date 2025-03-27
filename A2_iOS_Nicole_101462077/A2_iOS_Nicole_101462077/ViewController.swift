//
//  ViewController.swift
//  A2_iOS_Nicole_101462077
//
//  Created by Nicole Milmine on 2025-03-26.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var products: [Product] = []
    var displayProducts: [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        title = "Products"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addProduct))
        
        fetchProducts()
    }
    
    func fetchProducts() {
        let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
        
        do{
            products = try context.fetch(fetchRequest)
            tableView.reloadData()
        } catch {
            print("Error getting products: \(error)")
        }
    }
    
    @objc func addProduct() {
        let vc = AddProductViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt index: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: index)
        let product = displayProducts[index.row]
        cell.textLabel?.text = product.name
        cell.detailTextLabel?.text = product.description
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if  searchText.isEmpty {
            displayProducts = products
        } else {
            displayProducts = products.filter{ $0.name?.localizedCaseInsensitiveContains(searchText) == true || $0.desc?.localizedCaseInsensitiveContains(searchText) == true}
        }
        tableView.reloadData()
    }
    
    
}
