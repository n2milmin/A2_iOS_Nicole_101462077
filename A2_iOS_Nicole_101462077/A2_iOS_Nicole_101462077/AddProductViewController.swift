//
//  AddProductViewController.swift
//  A2_iOS_Nicole_101462077
//
//  Created by Nicole Milmine on 2025-03-27.
//

import Foundation
import UIKit
import CoreData

class AddProductViewController: UIViewController {
    
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var descTextField: UITextField!
    @IBOutlet var priceTextField: UITextField!
    @IBOutlet var providerTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add Product"
                
    }
    
    @IBAction func addBtn(_ sender: AnyObject) {
        let name = nameTextField.text ?? "unknown"
        let desc = descTextField.text ?? "unknown"
        let price = priceTextField.text ?? "0.0"
        let provider = providerTextField.text ?? "unknown"
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let product = Product(context: context)
        product.name = name
        product.desc = desc
        product.price = Double(price) ?? 0
        product.provider = provider
        
        let alert = UIAlertController(title: "Success", message: "Product added!", preferredStyle: .alert)
        
        do {
            try context.save()
            present(alert, animated: true)
        } catch {
            print("Something went wrong, please try again.")
        }
    }
    
}
