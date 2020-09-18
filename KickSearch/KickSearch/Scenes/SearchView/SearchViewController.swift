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
    @IBOutlet weak var filterViewHeight: NSLayoutConstraint!
    @IBOutlet weak var filterView: FilterView!
    
    private var baseData: [MainResponse] = []
    private var mainData: [MainResponse] = []
    private var filteredData: [MainResponse] = []
    private var handledData: [MainResponse] = []
    private var isSorted = false
    private var isFiltered = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        getData()
    }
    
    private func configureTableView() {
        tableView.register(UINib(nibName: "MainTableViewCell", bundle: nil), forCellReuseIdentifier: "listCell")
        tableView.separatorStyle = .none
        filterView.delegete = self
    }
    
    private func getData() {
        Request.shared.getData { (isSuccess, response) in
            if isSuccess {
                self.mainData = response!
                self.filteredData = self.mainData
                self.handledData = self.mainData
                self.baseData = self.mainData
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
    
    private func setDatas(_ isFiltered: Bool) {
        if isFiltered {
            mainData = baseData
            handledData = baseData
            filteredData = baseData
            tableView.reloadData()
        }
    }
  
    @IBAction func sortButtonAction(_ sender: UIButton) {
        isSorted = !isSorted
        let sortedData2 = handledData.sorted(by: {$0.title < $1.title})
        filteredData = isSorted ? sortedData2 : handledData
        tableView.reloadData()
    }
    
    @IBAction func filterButtonAction(_ sender: UIButton) {
        filterViewHeight.constant = isFiltered ? 0 : 50
        self.loadViewIfNeeded()
        setDatas(isFiltered)
        isFiltered = !isFiltered
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
        handledData = filteredData
        tableView.reloadData()
    }
    
    
}

//MARK: FilterViewDelegete
extension SearchViewController: FilterViewDelegete {
    
    func getButtonTag(senderTag: Int) {
        var filterWord = ""
        
        switch senderTag {
        case 0:
            filterWord = "usd"
        case 1:
            filterWord = "eur"
        case 2:
            filterWord = "cad"
        case 3:
            filterWord = "gbp"
        default:
            filterWord = "cad"
        }
        
        let currencyData = baseData.filter{ $0.currency == filterWord }
        filteredData = currencyData
        handledData = currencyData
        mainData = currencyData
        tableView.reloadData()
    }
    
}
