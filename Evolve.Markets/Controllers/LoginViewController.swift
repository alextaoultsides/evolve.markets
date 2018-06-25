//
//  ViewController.swift
//  Evolve.Markets
//
//  Created by atao on 5/27/18.
//  Copyright © 2018 atao. All rights reserved.
//

import UIKit
import SafariServices
import CoreData

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var loginButton: UIButton!
   
    var actInd: UIActivityIndicatorView!
    var sessionLoginCheck: Bool!
    var dataController: DataController!
    let loginTextfieldDelegate = LoginTextFieldDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        actInd = showActivityIndicator(uiView: self.view)
        setTextDelegate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        sessionLoginCheck = false
        emailTextField.text = ""
        passwordTextfield.text = ""
        
    }
    
    func setTextDelegate() {
        emailTextField.delegate = loginTextfieldDelegate
        passwordTextfield.delegate = loginTextfieldDelegate
    }
 
    
    @IBAction func login(_ sender: Any) {
        performUIUpdatesOnMain {
            self.actInd.startAnimating()
        }
        
        EMClient.sharedInstance().loginMethod(email: emailTextField.text!, password: passwordTextfield.text!) { (error) in
            if error != nil {
                self.displayError(error?.localizedDescription)
                let appLogin = AppLogins(context: self.dataController.viewContext)
                appLogin.loginDate = Date()
                appLogin.success = "Failed Login"
                try? self.dataController.viewContext.save()
                self.actInd.stopAnimating()
                return
            } else {
                
                let appLogin = AppLogins(context: self.dataController.viewContext)
                appLogin.loginDate = Date()
                appLogin.success = "Success"
                try? self.dataController.viewContext.save()
                EMClient.sharedInstance().dataController = self.dataController
                performUIUpdatesOnMain {
                    let controller = self.storyboard?.instantiateViewController(withIdentifier: "navView") as! NavViewController
                    self.view.endEditing(true)
                    self.present(controller, animated: true, completion: nil)
                    
                    self.actInd.stopAnimating()
                }
            }
        }
    }
    
    @IBAction func createAccount(_ sender: Any) {
        let app = UIApplication.shared
        app.open(URL(string: "https://mt5.clients.evolve.markets/join/")!, completionHandler: nil)
    }
    
    @IBAction func passRecovery(_ sender: Any) {
        let app = UIApplication.shared
        app.open(URL(string: "https://mt5.clients.evolve.markets/password/")!, completionHandler: nil)
    }
}

