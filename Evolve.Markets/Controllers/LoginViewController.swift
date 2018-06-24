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
        emailTextField.text = ""
        passwordTextfield.text = ""
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        sessionLoginCheck = false
        
    }
    
    func setTextDelegate() {
        emailTextField.delegate = loginTextfieldDelegate
        passwordTextfield.delegate = loginTextfieldDelegate
    }
 
    
    @IBAction func login(_ sender: Any) {
        performUIUpdatesOnMain {
            self.actInd.startAnimating()
        }
        
        
        EMClient().loginMethod(email: emailTextField.text!, password: passwordTextfield.text!) { (error) in
            if error != nil {
                self.displayError(error?.localizedDescription)
                self.actInd.stopAnimating()
            } else {
                let appLogin = AppLogins(context: self.dataController.viewContext)
                appLogin.loginDate = Date()
                print(appLogin.loginDate)
                try? self.dataController.viewContext.save()
                performUIUpdatesOnMain {
                    let controller = self.storyboard?.instantiateViewController(withIdentifier: "navView") as! NavViewController
                    self.view.endEditing(true)
                    EMClient.sharedInstance().dataController = self.dataController
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
    
//    func subscribeToKeyboardNotifications() {
//
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
//    }
//
//    func unsubscribeFromKeyboardNotifications() {
//
//        NotificationCenter.default.removeObserver(self)
//    }
//
//    @objc func keyboardWillHide(_ notification:Notification){
//        view.frame.origin.y = 0
//    }
//
//    @objc func keyboardWillShow(_ notification:Notification) {
//        if view.frame.origin.y == 0 {
//
//            view.frame.origin.y -= (getKeyboardHeight(notification) / 2.5)
//
//        }
//    }
}

