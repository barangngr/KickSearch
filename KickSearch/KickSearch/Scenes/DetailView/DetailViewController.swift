//
//  DetailViewController.swift
//  KickSearch
//
//  Created by Baran on 17.09.2020.
//  Copyright © 2020 Baran. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var byLabel: UILabel!
    @IBOutlet weak var blurbLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var backersLabel: UILabel!
    
    private let baseURL = "https://www.kickstarter.com"
    var data: MainResponse?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    private func configureView() {
        guard let data = data else { return }
        titleLabel.text = data.title
        endDateLabel.text = data.endTime.toDate()?.toString(format: "dd.MM.yyyy")
        byLabel.text = data.by
        blurbLabel.text = data.blurb
        countryLabel.text = "Country: \(data.country)"
        locationLabel.text = "Location: \(data.location)"
        currencyLabel.text = "Currency: \(data.currency.uppercased())"
        typeLabel.text = "Type: \(data.type)"
        amountLabel.text = "Amount: \(data.amtPledged)$"
        backersLabel.text = "Country: \(data.numBackers)"
    }

    @IBAction func goWebsiteButton(_ sender: UIButton) {
        guard let data = data, let url = URL(string: baseURL + data.url) else { return }
        UIApplication.shared.open(url)
    }
    
}
