//
//  UserAccountsViewController.swift
//  Evolve.Markets
//
//  Created by atao1 on 6/2/18.
//  Copyright © 2018 atao. All rights reserved.
//

import Foundation
import UIKit
import SCLAlertView


class UserAccountsViewController: UIViewController {
    
    @IBOutlet weak var accountTableView: UITableView!
    
    var userAccounts = EMClient.sharedInstance().user
    var amount: Double!
    var actInd: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        actInd = showActivityIndicator(uiView: self.view)
        accountTableView.allowsSelection = false
        

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //actInd.startAnimating()
        userAccounts = EMClient.sharedInstance().user
        performUIUpdatesOnMain {
            self.accountTableView.reloadData()
        }
    }
    
    @objc func demoAddFunds(_ sender:UIButton) {
        let accountNum = userAccounts?.accountDemo![sender.tag].metaID
        
        amountEnterPrompt() { (result) in
            if result != nil {
                self.amount = Double(result!)
                print(self.amount)
                EMClient.sharedInstance().demoPostFunds(accountNumber: accountNum!, amount: self.amount * pow(10, 8)) { (error) in
                    if error != nil {
                        self.displayError(error?.localizedDescription)
                    }
                    performUIUpdatesOnMain {
                        self.accountTableView.reloadData()
                    }
                }
            }
        }
    }
    
    @objc func demoDeleteAccount(_ sender: UIButton) {
        let accountNum = userAccounts?.accountDemo![sender.tag].metaID
        removeAccountPrompt(accountNum: accountNum!)
    }
    
    @objc func demoAccountSettings(_ sender: UIButton) {
        let account = userAccounts?.accountDemo![sender.tag]
        
        let controller = storyboard?.instantiateViewController(withIdentifier: "accountSettings") as! AccountSettingsViewController
        
        controller.account = account
        
        present(controller, animated: true, completion: nil)
    }
    
    //MARK: Alert for entering
    func amountEnterPrompt(completion: @escaping(String?) -> Void) {
        let appearance = SCLAlertView.SCLAppearance(
            showCircularIcon: true
        )
        let alert = SCLAlertView(appearance: appearance)
        let alertViewIcon = UIImage(named: "EM")
        let txt = alert.addTextField("Enter amount")
        txt.keyboardType = .decimalPad
        
        alert.addButton("Save") {
            completion(txt.text)
        }
        
        alert.showEdit("Amount", subTitle: "BTC",closeButtonTitle: "Cancel",colorStyle: 0x007AFF, circleIconImage: alertViewIcon)
        
        if alert.isShowing() == false {
            completion(nil)
        }
    }
    
    //MARK: Alert for Removing Account
    func removeAccountPrompt(accountNum: Int) {
        let appearance = SCLAlertView.SCLAppearance(
            showCircularIcon: true
        )
        let alert = SCLAlertView(appearance: appearance)
        let alertViewIcon = UIImage(named: "EM")
        
        alert.addButton("Yes") {
            EMClient.sharedInstance().deleteAccount(accountNumber:accountNum) {(error) in
                if error != nil {
                    self.displayError(error?.localizedDescription)
                }
            }
        }
        
        alert.showEdit("Delete Account?", subTitle: "\(accountNum)",closeButtonTitle: "No",colorStyle: 0x007AFF, circleIconImage: alertViewIcon)
    }
}


extension UserAccountsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            if let row = EMClient.sharedInstance().user {
                return (row.accountLive?.count)! + 1
            }
        } else if section == 1 {
            if let row = EMClient.sharedInstance().user {
                return (row.accountDemo?.count)! + 1
            }
        }
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0,indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "liveAccountLabel")
            return cell!
        } else if indexPath.section == 0 && indexPath.row > 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "liveAccountCell") as! AccountCell
            if let user = EMClient.sharedInstance().user {
                cell.accountBalance.text = "\(user.accountLive![indexPath.row - 1].balance!) \(user.accountLive![indexPath.row - 1].denomination!)"
                cell.accountType.text = String(describing: user.accountLive![indexPath.row - 1].group!)
                cell.accountName.text = String(describing: user.accountLive![indexPath.row - 1].name!)
                cell.accountNumber.text = "\(user.accountLive![indexPath.row - 1].metaID!)"
                cell.accountLeverage.text = "\(user.accountLive![indexPath.row - 1].leverage!):1"
                cell.withdrawButton.layer.borderWidth = 1
                cell.withdrawButton.layer.borderColor = UIColor.blue.cgColor
                cell.setButton()
            }
            return cell
        } else if indexPath.section == 1 && indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "demoAccountLabel")
            return cell!
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "demoAccountCell") as! AccountCell
            if let user = EMClient.sharedInstance().user {
                let balance = String(format: "%.8f", (user.accountDemo![indexPath.row - 1].balance! / pow(10, 8)))
                cell.accountBalance.text = "\(balance) \(user.accountDemo![indexPath.row - 1].denomination!)"
                cell.accountType.text = user.accountDemo![indexPath.row - 1].group!
                cell.accountName.text = user.accountDemo![indexPath.row - 1].name!
                cell.accountNumber.text = "\(user.accountDemo![indexPath.row - 1].metaID!)"
                cell.accountLeverage.text = "\(user.accountDemo![indexPath.row - 1].leverage!):1"
                cell.withdrawButton.layer.borderWidth = 1
                cell.withdrawButton.layer.borderColor = UIColor.blue.cgColor
                cell.setButton()
                cell.withdrawButton.tag = indexPath.row - 1
                cell.withdrawButton.addTarget(self, action: #selector(self.demoDeleteAccount(_:)), for: .touchUpInside)
                cell.depositButton.tag = indexPath.row - 1
                cell.depositButton.addTarget(self, action: #selector(self.demoAddFunds(_: )), for: .touchUpInside)
                cell.settingsButton.tag = indexPath.row - 1
                cell.settingsButton.addTarget(self, action: #selector(self.demoAccountSettings(_:)), for: .touchUpInside)
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Live Accountsss"
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let accountTableView = UIView()
        
        return accountTableView
    }
    
    
}

