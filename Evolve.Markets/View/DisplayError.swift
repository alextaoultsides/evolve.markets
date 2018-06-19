//
//  DisplayError.swift
//  Evolve.Markets
//
//  Created by atao1 on 5/30/18.
//  Copyright © 2018 atao. All rights reserved.
//

import Foundation
import UIKit

extension  UIViewController {
    
    func displayError(_ errorString: String?) {
        
        if let errorString = errorString {
            let alert = UIAlertController(title: "Alert", message: errorString, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
                NSLog("The \"OK\" alert occured.")
            }))
            performUIUpdatesOnMain {
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}
