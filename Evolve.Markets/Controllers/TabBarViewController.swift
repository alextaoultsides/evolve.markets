//
//  TabBarViewController.swift
//  Evolve.Markets
//
//  Created by atao1 on 7/10/18.
//  Copyright © 2018 atao. All rights reserved.
//

import Foundation
import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarItem.badgeColor = UIColor.lightGray
        let newWhite = UIColor.white
        newWhite.withAlphaComponent(0.2)
        
        self.tabBar.unselectedItemTintColor = UIColor.blue    }
    
    
}
