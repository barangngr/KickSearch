//
//  ViewController.swift
//  KickSearch
//
//  Created by Baran on 16.09.2020.
//  Copyright © 2020 Baran. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var tableViewData: [MainResponse] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        getData()
    }
    
    private func configureTableView() {
        tableView.register(UINib(nibName: "MainTableViewCell", bundle: nil), forCellReuseIdentifier: "listCell")
        tableView.separatorStyle = .none
    }
    
    private func getData() {
        Request.shared.getData { (isSuccess, response) in
            print("")
            if isSuccess {
                self.tableViewData = response!
                self.tableView.reloadData()
            }
        }
    }

}

//MARK: UITableViewDataSource
extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as! MainTableViewCell
        cell.configureCell(tableViewData[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }

}

//MARK: UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 119.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
}
