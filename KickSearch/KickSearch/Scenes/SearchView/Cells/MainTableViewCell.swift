//
//  MainTableViewCell.swift
//  KickSearch
//
//  Created by Baran on 16.09.2020.
//  Copyright © 2020 Baran. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var backersLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(_ data: MainResponse) {
        titleLabel.text = data.title
        countryLabel.text = data.location
        endDateLabel.text = data.endTime.toDate()?.toString(format: "dd.MM.yyyy")
        backersLabel.text = "Backers: \(data.numBackers)"
    }
    
}
