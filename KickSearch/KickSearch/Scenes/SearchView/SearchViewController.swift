//
//  ViewController.swift
//  KickSearch
//
//  Created by Baran on 16.09.2020.
//  Copyright © 2020 Baran. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        Request.shared.getData { (isSuccess, response) in
            print("")
        }
    }

}
