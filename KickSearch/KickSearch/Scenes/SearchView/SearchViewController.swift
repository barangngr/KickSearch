//
//  ViewController.swift
//  KickSearch
//
//  Created by Baran on 16.09.2020.
//  Copyright © 2020 Baran. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    //MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var filterViewHeight: NSLayoutConstraint!
    @IBOutlet weak var filterView: FilterView!
    
    //MARK: Variables
    private var filteredData: [MainResponse] = []
    private lazy var presenter = SearchViewPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        presenter.load()
        keyboardConfigure()
    }
    
    private func configure() {
        filterView.delegete = self
        presenter.delegete = self
        
        configureTableView()
        showHUD()
    }
    
    private func configureTableView() {
        tableView.register(UINib(nibName: "MainTableViewCell", bundle: nil), forCellReuseIdentifier: "listCell")
        tableView.separatorStyle = .none
    }
    
    private func setNumberOfRows() -> Int {
        if filteredData.count == 0 {
            self.tableView.setEmptyMessage("Upps! No such thing")
        } else {
            self.tableView.restore()
        }
        return filteredData.count
    }
    
    //MARK: Actions
    @IBAction func sortButtonAction(_ sender: UIButton) {
        //Default olarak Backers sayısına göre sıralı gelen datayı, titlle baz alınarak alfabetik sıraya sokma işlemi yapıllmıştır.
        presenter.sortButtonResponse()
    }
    
    @IBAction func filterButtonAction(_ sender: UIButton) {
        //Filtreleme ekranında reponse içerisindeki currency baz alınarak basit bir filtreleme seçeneği sunulmuştur.
        presenter.filterButtonHeightResponse(viewHeight: Float(filterViewHeight.constant))
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
        presenter.searchBarResponse(searchText)
    }
    
}

//MARK: FilterViewDelegete
extension SearchViewController: FilterViewDelegete {
    
    func getButtonTag(senderTag: Int) {
        presenter.filterButtonResponse(senderTag: senderTag)
    }
    
}

//MARK: SearchViewPresenterDelegete
extension SearchViewController: SearchViewPresenterDelegete {
    
    func handleOutput(_ output: PresenterOutput) {
        switch output {
        case .updateData(let data):
            filteredData = data
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.hideHUD()
            }
            
        case .filterButtonResponse(let height):
            filterViewHeight.constant = CGFloat(height)
            self.loadViewIfNeeded()
        }
    }
    
}
