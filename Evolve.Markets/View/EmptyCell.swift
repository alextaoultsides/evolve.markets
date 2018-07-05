//
//  emptyCell.swift
//  Evolve.Markets
//
//  Created by atao1 on 7/4/18.
//  Copyright © 2018 atao. All rights reserved.
//

import Foundation
import UIKit

class EmptyCell: UITableViewCell {
    
    override func prepareForReuse() {
        frame.size.height = 5.0
    }
    
    
}
