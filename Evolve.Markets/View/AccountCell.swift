//
//  AccountCell.swift
//  Evolve.Markets
//
//  Created by atao1 on 6/6/18.
//  Copyright © 2018 atao. All rights reserved.
//

import Foundation
import UIKit

class AccountCell: UITableViewCell {
    
    @IBOutlet weak var loginTextLabel: UILabel!
    @IBOutlet weak var accountNumber: UILabel!
    @IBOutlet weak var accountName: UILabel!
    @IBOutlet weak var accountType: UILabel!
    @IBOutlet weak var accountLeverage: UILabel!
    @IBOutlet weak var accountBalance: UILabel!
    @IBOutlet weak var depositButton: UIButton!
    @IBOutlet weak var withdrawButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var webtraderButton: UIButton!
    @IBOutlet weak var bottomStackView: UIStackView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        setButton()
    }
    
    func setButton() {
        withdrawButton.backgroundColor = .clear
        withdrawButton.layer.borderWidth = 1
        withdrawButton.layer.borderColor = UIColor.blue.cgColor
        
        let topBorder = CALayer()
        topBorder.borderColor = UIColor.lightGray.cgColor
        topBorder.borderWidth = 1
        topBorder.frame = CGRect.init(x: 0, y: 0, width: self.frame.width, height: 1)
        bottomStackView.layer.addSublayer(topBorder)
        
        let rightBorder = CALayer()
        rightBorder.borderColor = UIColor.lightGray.cgColor
        rightBorder.borderWidth = 1
        rightBorder.frame = CGRect.init(x: settingsButton.frame.width, y: 0, width: 1, height: settingsButton.frame.height)
        settingsButton.layer.addSublayer(rightBorder)
    }
    
}
