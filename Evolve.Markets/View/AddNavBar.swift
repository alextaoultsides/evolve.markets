//
//  AddNavBar.swift
//  Evolve.Markets
//
//  Created by atao1 on 7/22/18.
//  Copyright © 2018 atao. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func addNavBar(){
        let screenSize: CGRect = UIScreen.main.bounds
        
        let navbar = UINavigationBar(frame: CGRect(x: 0, y: 20, width: screenSize.width, height: 64))
        navbar.backgroundColor = UIColor.init(red: 0.0, green: 0.478, blue: 1.0, alpha: 0.0)
        
        navbar.barTintColor = UIColor.init(red: 0.0, green: 0.478, blue: 1.0, alpha: 1.0)
//        
//        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self,action: #selector(self.saveUpdates))
//        saveButton.title = "Save"
//        saveButton.tintColor = UIColor.white
//        
//        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self,action: #selector(self.dismissController(_:)))
//        cancelButton.title = "Cancel"
//        cancelButton.tintColor = UIColor.white
//        let navItem = UINavigationItem()
//        
//        navItem.rightBarButtonItem = saveButton
//        navItem.leftBarButtonItem = cancelButton
//        navItem.title = "Account Settings: \(account.metaID!)"
//        
 //       navbar.setItems([navItem], animated: true)
        self.view.addSubview(navbar)
    }
}
