//
//  SearchViewPresenter.swift
//  KickSearch
//
//  Created by Baran on 16.09.2020.
//  Copyright © 2020 Baran. All rights reserved.
//

import Foundation

class SearchViewPresenter {
    
    //MARK: Variables
    private var baseData: [MainResponse] = []
    private var mainData: [MainResponse] = []
    private var filteredData: [MainResponse] = []
    private var handledData: [MainResponse] = []
    private var isSorted = false
    private var isFiltered = false
    
    weak var delegete: SearchViewPresenterDelegete?
    
    //MARK: Functions
    func load() {
        fetchData()
    }
    
    func searchBarResponse(_ searchText: String) {
        let searchData = mainData.filter{ $0.title.contains(searchText)}
        filteredData = searchText.isEmpty ? mainData : searchData
        handledData = filteredData
        delegete?.handleOutput(.updateData(filteredData))
    }
    
    func sortButtonResponse() {
        isSorted = !isSorted
        let sortedData2 = handledData.sorted(by: {$0.title < $1.title})
        filteredData = isSorted ? sortedData2 : handledData
        delegete?.handleOutput(.updateData(filteredData))
    }
    
    func filterButtonHeightResponse(viewHeight: Float) {
        let height: Float = isFiltered ? 0 : 50
        setDatas(isFiltered)
        isFiltered = !isFiltered
        delegete?.handleOutput(.filterButtonResponse(height))
    }
    
    func filterButtonResponse(senderTag: Int) {
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
        delegete?.handleOutput(.updateData(currencyData))
    }
    
    private func setDatas(_ isFiltered: Bool) {
        if isFiltered {
            mainData = baseData
            handledData = baseData
            filteredData = baseData
            delegete?.handleOutput(.updateData(filteredData))
        }
    }
    
    private func fetchData() {
        Request.shared.getData { (isSuccess, response) in
            if isSuccess, let data = response {
                self.mainData = data
                self.handledData = data
                self.baseData = data
                self.filteredData = data
                self.delegete?.handleOutput(.updateData(data))
            }
        }
    }
    
}
