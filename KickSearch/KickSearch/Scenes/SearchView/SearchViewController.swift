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
    
    private var mainData: [MainResponse] = []
    private var filteredData: [MainResponse] = []
    
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
                self.mainData = response!
                self.filteredData = self.mainData
                self.tableView.reloadData()
            }
        }
    }
    
    private func setNumberOfRows() -> Int {
        if filteredData.count == 0 {
            self.tableView.setEmptyMessage("Upps! No such thing")
        } else {
            self.tableView.restore()
        }
        return filteredData.count
    }

}

//MARK: UITableViewDataSource
extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return setNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as! MainTableViewCell
        cell.configureCell(filteredData[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }

}

//MARK: UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 101.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        vc.data = filteredData[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

//MARK: UISearchbarDelegete
extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let searchData = mainData.filter{ $0.title.contains(searchText)}
        filteredData = searchText.isEmpty ? mainData : searchData
        tableView.reloadData()
    }
    
}
