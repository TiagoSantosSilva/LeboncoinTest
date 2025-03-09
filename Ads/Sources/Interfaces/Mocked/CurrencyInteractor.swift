//
//  CurrencyInteractor.swift
//  Ads
//
//  Created by Tiago Silva on 09/03/2025.
//

protocol CurrencyInteractorProtocol {
    var displayCurrency: String { get }
}

final class CurrencyInteractor: CurrencyInteractorProtocol {
    var displayCurrency: String {
        "€"
    }
}
