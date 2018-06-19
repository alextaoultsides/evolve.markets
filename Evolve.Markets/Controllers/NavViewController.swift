//
//  NavViewController.swift
//  Evolve.Markets
//
//  Created by atao1 on 6/11/18.
//  Copyright © 2018 atao. All rights reserved.
//

import Foundation
import UIKit

class NavViewController: UINavigationController {
    
    @IBOutlet weak var navBar: UINavigationBar!
    
    override func viewDidLoad() {
        
        navBar.topItem?.title = "Evolve Markets"
        let logOutButton = UINavigationItem()
        logOutButton.rightBarButtonItem = UIBarButtonItem(title: "logout", style: .plain, target: self, action: #selector(logOut))
        
        navBar.backItem?.backBarButtonItem = UIBarButtonItem(title: "logout", style: .plain, target: self, action: #selector(logOut))
        navBar.items?.append(logOutButton)
    }
    
    @objc func logOut() {
        EMClient.sharedInstance().deleteSession() {(error) in
            if error != nil {
                self.displayError(error?.localizedDescription)
            } else {
                EMClient.sharedInstance().user = nil
                EMClient.sharedInstance().sessionID = ""

                self.dismiss(animated: true)
            }
        }
    }
}
