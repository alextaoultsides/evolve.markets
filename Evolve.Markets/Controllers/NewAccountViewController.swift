//
//  NewAccountViewController.swift
//  Evolve.Markets
//
//  Created by atao1 on 7/22/18.
//  Copyright © 2018 atao. All rights reserved.
//

import Foundation
import UIKit

class NewAccountViewController: UIViewController {
    
    @IBOutlet weak var newAccountTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    @IBOutlet weak var newAccountTypeControl: UISegmentedControl!
    @IBOutlet weak var newAccountCurrency: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNavBar()
    }
    
    
    func addNavBar(){
        let screenSize: CGRect = UIScreen.main.bounds
        
        let navbar = UINavigationBar(frame: CGRect(x: 0, y: 20, width: screenSize.width, height: 64))
        navbar.backgroundColor = UIColor.init(red: 0.0, green: 0.478, blue: 1.0, alpha: 0.0)
        
        navbar.barTintColor = UIColor.init(red: 0.0, green: 0.478, blue: 1.0, alpha: 1.0)
        
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self,action: #selector(self.saveUpdates))
        saveButton.title = "Save"
        saveButton.tintColor = UIColor.white
        
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self,action: #selector(self.dismissController(_:)))
        cancelButton.title = "Cancel"
        cancelButton.tintColor = UIColor.white
        let navItem = UINavigationItem()
        
        navItem.rightBarButtonItem = saveButton
        navItem.leftBarButtonItem = cancelButton
        navItem.title = "Add New Account"
        
        navbar.setItems([navItem], animated: true)
        self.view.addSubview(navbar)
    }
    
    @objc func saveUpdates(_ sender: UIButton) {
        EMClient.sharedInstance().postNewAccount{(error) in
            if error != nil {
                self.displayError(error?.localizedDescription)
            }
        }
    }
    
    @objc func dismissController(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
