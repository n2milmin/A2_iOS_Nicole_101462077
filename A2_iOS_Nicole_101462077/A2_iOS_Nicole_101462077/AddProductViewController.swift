//
//  AddProductViewController.swift
//  A2_iOS_Nicole_101462077
//
//  Created by Nicole Milmine on 2025-03-27.
//

import Foundation
import UIKit
import CoreData

class AddProductViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var descTextField: UITextField!
    @IBOutlet var priceTextField: UITextField!
    @IBOutlet var providerTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add Product"
                
        nameTextField.delegate = self
        descTextField.delegate = self
        priceTextField.delegate = self
        providerTextField.delegate = self
    }
    
    @IBAction func addBtn(_ sender: UIButton) {
        let name = nameTextField.text ?? "unknown"
        let desc = descTextField.text ?? "unknown"
        let priceText = priceTextField.text ?? "0.0"
        let provider = providerTextField.text ?? "unknown"

        guard let price = Double(priceText) else {
            print("Price must be numeric.")
            return
        }
        
       let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let product = Product(context: context)
        product.id = UUID()
        product.name = name
        product.desc = desc
        product.price = price
        product.provider = provider
        
        let alert = UIAlertController(title: "Success", message: "Product added!", preferredStyle: .alert)
        
        do {
            try context.save()
            present(alert, animated: true)
            self.dismiss(animated: true, completion:  nil)
        } catch {
            print("Something went wrong, please try again.")
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
