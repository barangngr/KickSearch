//
//  FilterView.swift
//  KickSearch
//
//  Created by Baran on 17.09.2020.
//  Copyright © 2020 Baran. All rights reserved.
//

import UIKit

protocol FilterViewDelegete {
    func getButtonTag(senderTag: Int)
}

class FilterView: UIView {
    
    @IBOutlet weak var usdButton: UIButton!
    @IBOutlet weak var eurButton: UIButton!
    @IBOutlet weak var cadButton: UIButton!
    @IBOutlet weak var gbpButton: UIButton!
    @IBOutlet weak var audButton: UIButton!
    @IBOutlet var view: UIView!
    
    var delegete: FilterViewDelegete!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        UINib(nibName: "FilterView", bundle: nil).instantiate(withOwner: self, options: nil)
        addSubview(view)
        view.frame = self.bounds
    }
    
    @IBAction func buttonActions(_ sender: UIButton) {
        delegete.getButtonTag(senderTag: sender.tag)
        setButtonBackground(sender.tag)
    }
    
    private func setButtonBackground(_ tag: Int) {
        let btnArray: [UIButton] = [usdButton, eurButton, cadButton, gbpButton, audButton]
        for i in btnArray {
            if tag == i.tag {
                i.backgroundColor = .purple
                i.layer.cornerRadius = (i.frame.height)/2
            } else {
                i.backgroundColor = .clear
            }
        }
    }
    
}
