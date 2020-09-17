//
//  FilterView.swift
//  KickSearch
//
//  Created by Baran on 17.09.2020.
//  Copyright © 2020 Baran. All rights reserved.
//

import UIKit

class FilterView: UIView {
    
    @IBOutlet weak var usdButton: UIButton!
    @IBOutlet weak var eurButton: UIButton!
    @IBOutlet weak var cadButton: UIButton!
    @IBOutlet weak var gbpButton: UIButton!
    @IBOutlet weak var audButton: UIButton!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func buttonActions(_ sender: UIButton) {
        print(sender.tag)
    }
    
}
