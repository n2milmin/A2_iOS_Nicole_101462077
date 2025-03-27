//
//  AddProductViewController.swift
//  A2_iOS_Nicole_101462077
//
//  Created by Nicole Milmine on 2025-03-27.
//

import UIKit
import CoreData

class AddProductViewController: UIViewController {
    
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet var textFields: [UITextField]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPurple
        title = "Add Product"
                
    }
    
    @IBAction func addBtn(_ sender: UIButton) {
        let name = textFields[0].text ?? "unknown"
        let desc = textFields[1].text ?? "unknown"
        let price = textFields[2].text ?? "0.00"
        let provider = textFields[3].text ?? "unknown"
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let product = Product(context: context)
        product.name = name
        product.desc = desc
        product.price = Double(price) ?? 0
        product.provider = provider
        
        do {
            try context.save()
            print("Product added!")
        } catch {
            print("Something went wrong, please try again.")
        }
    }
}
