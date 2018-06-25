//
//  UserSettingsViewController.swift
//  Evolve.Markets
//
//  Created by atao1 on 6/24/18.
//  Copyright © 2018 atao. All rights reserved.
//

import Foundation
import UIKit

class UserSettingsViewController: UIViewController {
    
    @IBOutlet weak var loginSwitch: UISwitch!
    @IBOutlet weak var balanceSwitch: UISwitch!
    @IBOutlet weak var promoSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSwitches()
    }
    
    
    func setSwitches() {
        var notifications = EMClient.sharedInstance().user.notifications
        if notifications!["login"] == 1 {
            loginSwitch.isOn = true
        } else {
            loginSwitch.isOn = false
        }
        if notifications!["balance"] == 1 {
            balanceSwitch.isOn = true
        } else {
            balanceSwitch.isOn = false
        }
        if notifications!["promo"] == 1 {
            promoSwitch.isOn = true
        } else {
            promoSwitch.isOn = false
        }
    }
    @IBAction func loginSwitchChange(_ sender: Any) {
        EMClient.sharedInstance().updateEmailSettings(switchState: loginSwitch.isOn, switchName: "login"){(error) in
            if error != nil {
                self.displayError(error?.localizedDescription)
            }
        }
    }
    @IBAction func balanceSwitchChange(_ sender: Any) {
        EMClient.sharedInstance().updateEmailSettings(switchState: balanceSwitch.isOn, switchName: "balance"){(error) in
            if error != nil {
                self.displayError(error?.localizedDescription)
            }
        }
    }
    
    
    @IBAction func promoSwitchChange(_ sender: Any) {
        EMClient.sharedInstance().updateEmailSettings(switchState: promoSwitch.isOn, switchName: "promo"){(error) in
            if error != nil {
                self.displayError(error?.localizedDescription)
            }
        }
    }
    
}
