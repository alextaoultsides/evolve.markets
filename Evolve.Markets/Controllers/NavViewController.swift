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
        logOutButton.leftBarButtonItem = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(logOut))
        logOutButton.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refresh))
        
        logOutButton.leftBarButtonItem?.tintColor = UIColor.white
        logOutButton.rightBarButtonItem?.tintColor = UIColor.white
        
        navBar.backItem?.hidesBackButton = true
       
        navBar.items?.append(logOutButton)
    }
    //MARK: log out of session
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
    //MARK: Refresh
    @objc func refresh() {
        
        self.visibleViewController?.viewDidLoad()
        self.visibleViewController?.viewWillAppear(true)
        
    }
    
    
}
