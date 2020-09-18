//
//  UIViewController.swift
//  KickSearch
//
//  Created by Baran on 18.09.2020.
//  Copyright © 2020 Baran. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func keyboardConfigure() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
