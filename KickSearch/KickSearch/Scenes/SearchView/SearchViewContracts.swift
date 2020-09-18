//
//  SearchViewContracts.swift
//  KickSearch
//
//  Created by Baran on 18.09.2020.
//  Copyright © 2020 Baran. All rights reserved.
//

import Foundation

enum PresenterOutput {
    case updateData(_ data: [MainResponse])
    case filterButtonResponse(_ viewHeight: Float)
}

protocol SearchViewPresenterDelegete: class {
    func handleOutput(_ output: PresenterOutput)
}

// Daha kapsamlı bir mimaride yada ileride delegete patternlerin kontrolü adına böyle bir düzen tercih edilmiştir.Biraz MVVM ve VİPER dan kalma alışkanlık.
