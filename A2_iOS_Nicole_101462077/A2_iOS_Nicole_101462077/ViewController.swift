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
    @IBOutlet weak var addButton : UIButton!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var products: [Product] = []
    var displayProducts: [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        title = "Products"

        insertSampleData()
        fetchProducts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchProducts()
    }

    func insertSampleData(context: NSManagedObjectContext) {
    let sampleProducts = [
        (id: UUID(), name: "Laptop", desc: "High-performance laptop", price: 1200.0, provider: "TechStore"),
        (id: UUID(), name: "Smartphone", desc: "Latest model smartphone", price: 900.0, provider: "PhoneHub"),
        (id: UUID(), name: "Headphones", desc: "Noise-canceling headphones", price: 250.0, provider: "AudioMax"),
        (id: UUID(), name: "Smartwatch", desc: "Fitness tracking smartwatch", price: 300.0, provider: "GadgetWorld")
    ]
    
    for item in sampleProducts {
        let product = Product(context: context)
        product.id = item.id
        product.name = item.name
        product.desc = item.desc
        product.price = item.price
        product.provider = item.provider
    }
}
    
    func fetchProducts() {
        let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
        
        do{
            products = try context.fetch(fetchRequest)
            displayProducts = products
            tableView.reloadData()
        } catch {
            print("Error getting products: \(error)")
        }
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
