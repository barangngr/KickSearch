//
//  UIViewController.swift
//  KickSearch
//
//  Created by Baran on 18.09.2020.
//  Copyright © 2020 Baran. All rights reserved.
//

import UIKit

fileprivate var hudView: UIView?

extension UIViewController {
    
    func keyboardConfigure() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func showHUD() {
        DispatchQueue.main.async {
            hudView = UIView(frame: self.view.bounds)
            hudView?.backgroundColor = UIColor.clear
            
            let hud = UIActivityIndicatorView(style: .whiteLarge)
            hud.center = hudView!.center
            hud.color = .systemPink
            hud.startAnimating()
            hudView?.addSubview(hud)
            self.view.addSubview(hudView!)
        }
    }
    
    func hideHUD() {
        hudView?.removeFromSuperview()
        hudView = nil
    }
    
}
