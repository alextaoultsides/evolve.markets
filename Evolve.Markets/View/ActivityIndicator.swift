//
//  ActivityIndicator.swift
//  Evolve.Markets
//
//  Created by atao1 on 6/15/18.
//  Copyright © 2018 atao. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    
    func showActivityIndicator(uiView: UIView) -> UIActivityIndicatorView{
        let actInd: UIActivityIndicatorView = UIActivityIndicatorView()
        actInd.frame = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0)
        actInd.backgroundColor = UIColor.gray
        actInd.alpha = 0.5
        actInd.center = self.view.center
        actInd.hidesWhenStopped = true
        actInd.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        
        self.view.addSubview(actInd)
        return actInd
    }
    
}
