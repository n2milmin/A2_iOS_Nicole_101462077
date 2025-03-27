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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ProductCell")
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        title = "Products"

//        insertSampleData(context: context)
        fetchProducts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchProducts()
    }

//    func insertSampleData(context: NSManagedObjectContext) {
//    let sampleProducts = [
//        (id: UUID(), name: "Laptop", desc: "High-performance laptop", price: 1200.0, provider: "TechStore"),
//        (id: UUID(), name: "Smartphone", desc: "Latest model smartphone", price: 900.0, provider: "PhoneHub"),
//        (id: UUID(), name: "Headphones", desc: "Noise-canceling headphones", price: 250.0, provider: "AudioMax"),
//        (id: UUID(), name: "Smartwatch", desc: "Fitness tracking smartwatch", price: 300.0, provider: "GadgetWorld")
//    ]
//    
//    for item in sampleProducts {
//        let product = Product(context: context)
//        product.id = item.id
//        product.name = item.name
//        product.desc = item.desc
//        product.price = item.price
//        product.provider = item.provider
//    }
//        
//        do {
//            try context.save()
//        } catch {
//            print("FUCKNO")
//        }
//}
    
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
        cell.detailTextLabel?.text = product.desc
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
    
    @IBAction func addProduct(_ sender: UIBarButtonItem){
        let alert = UIAlertController(title: "New Product", message: "Add a new product", preferredStyle: .alert)
        
        alert.addTextField{textField in textField.placeholder = "Name"}
        alert.addTextField{textField in textField.placeholder = "Description"}
        alert.addTextField{textField in textField.placeholder = "Price"
            textField.keyboardType = .numberPad}
        alert.addTextField{textField in textField.placeholder = "Provider"
            textField.keyboardType = .default}
        
        let saveAction = UIAlertAction(title: "Save", style: .default) {
            [unowned self] action in
            guard let name = alert.textFields?[0].text,
                  let desc = alert.textFields?[1].text,
                  let price = alert.textFields?[2].text,
                  let provider = alert.textFields?[3].text else {
                return
            }
            
            let newProduct = Product(context: context)
            newProduct.name = name
            newProduct.desc = desc
            newProduct.price = Double(price) ?? 0
            newProduct.provider = provider
            
            do {
                try context.save()
                tableView.reloadData()
            } catch {
                let errorAlert = UIAlertController(title: "Error", message: "Something went wrong, please try again.", preferredStyle: .alert)
                self.present(errorAlert, animated: true)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
}
