//
//  AccountSettingsViewController.swift
//  Evolve.Markets
//
//  Created by atao1 on 6/18/18.
//  Copyright © 2018 atao. All rights reserved.
//

import Foundation
import UIKit
import AlamofireNetworkActivityIndicator

class AccountSettingsViewController: UIViewController {
    
    @IBOutlet weak var setAccountNameTextfield: UITextField!
    @IBOutlet weak var setLeveragePickerView: UIPickerView!
    @IBOutlet weak var setAccountType: UISegmentedControl!
    @IBOutlet weak var deleteAccountButton: UIButton!
    
    var account: EMAccount!
    let leverages = ["FX 500 - BTC 50", "FX 200 - BTC 25", "FX 100 - BTC 10", "FX 50 - BTC 5"]
    let newLeverages = ["500", "200", "100", "50"]
    let loginTextfieldDelegate = LoginTextFieldDelegate()
    var actInd: UIActivityIndicatorView!
    
    //MARK: Set UI
    fileprivate func setUI() {
        setAccountNameTextfield.delegate = loginTextfieldDelegate
        setAccountNameTextfield.placeholder = account.name
        setLeveragePickerView.delegate = self
        setLeveragePickerView.dataSource = self
        setLeveragePickerView.selectRow(currentLeverage(), inComponent: 0, animated: false)
        
        if account.group == "Pro" {
            setAccountType.selectedSegmentIndex = 0
        } else {
            setAccountType.selectedSegmentIndex = 1
        }
        
        deleteAccountButton.addTarget(self, action: #selector(self.demoDeleteAccount(_:)), for: .touchUpInside)
        if account.accountType == "live" {
            deleteAccountButton.isEnabled = false
            deleteAccountButton.alpha = 0.5
        }
    }
    
    //MARK: View Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        actInd = showActivityIndicator(uiView: self.view)
        performUIUpdatesOnMain {
            self.setUI()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addNavBar()
    }
    
    //MARK: Navigation Bar
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
        navItem.title = "Account Settings: \(account.metaID!)"
        
        navbar.setItems([navItem], animated: true)
        self.view.addSubview(navbar)
    }
    
    //MARK: Updates account settings if they have changed
    @objc func saveUpdates(_ sender: UIButton) {
        performUIUpdatesOnMain {
            self.actInd.startAnimating()
        }
        
        if setAccountNameTextfield.text! != "" {
            EMClient.sharedInstance().updateAccount(accountId: account.metaID!, accountType: account.accountType!, updateType: "name", updatedItem: setAccountNameTextfield.text!){ (error) in
                if error != nil{
                    self.displayError(error?.localizedDescription)
                }
                performUIUpdatesOnMain {
                    self.actInd.stopAnimating()
                }
            }
        }
        performUIUpdatesOnMain {
            self.actInd.startAnimating()
        }
        if setLeveragePickerView.selectedRow(inComponent: 0) != currentLeverage() {
            setLeveragePickerView.selectedRow(inComponent: 0)
            EMClient.sharedInstance().updateAccount(accountId: account.metaID!, accountType: account.accountType!, updateType: "leverage", updatedItem: newLeverages[setLeveragePickerView.selectedRow(inComponent: 0)]){ (error) in
                if error != nil{
                    self.displayError(error?.localizedDescription)
                }
                performUIUpdatesOnMain {
                    self.actInd.stopAnimating()
                }
            }
        }
        performUIUpdatesOnMain {
            self.actInd.startAnimating()
        }
        if setAccountType.titleForSegment(at: setAccountType.selectedSegmentIndex) != account.group {
            print("\(account.accountType!) \(account.group!) \(setAccountType.titleForSegment(at: setAccountType.selectedSegmentIndex)!)")
            EMClient.sharedInstance().updateAccount(accountId: account.metaID!, accountType: account.accountType!, updateType: "group", updatedItem: setAccountType.titleForSegment(at: setAccountType.selectedSegmentIndex)!){ (error) in
                if error != nil{
                    self.displayError(error?.localizedDescription)
                }
                performUIUpdatesOnMain {
                    self.actInd.stopAnimating()
                }
            }
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: Delete account button
    @objc func demoDeleteAccount(_ sender: UIButton) {
        let accountNum = account.metaID
        UserAccountsViewController().removeAccountPrompt(accountNum: accountNum!)
        dismiss(animated: true, completion: nil)
    }
    //MARK: Dismiss Controller
    @objc func dismissController(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    //Sets current leverage to picker view
    func currentLeverage() -> Int{
        switch account.leverage! {
        case 200:
            return 1
        case 100:
            return 2
        case 50:
            return 3
        default:
            return 0
        }
    }
}

//MARK: Picker View Delegate
extension AccountSettingsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 4
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return leverages[row]
    }

}
