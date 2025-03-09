//
//  AdListApiServiceMock.swift
//  Ads
//
//  Created by Tiago Silva on 09/03/2025.
//

import Foundation
@testable import Ads

final class AdListApiServiceMock: AdListApiServiceProtocol {
    var loadAdsReturnValue: [AdApiDto]!
    var loadAdsError: Error?
    var loadAdsCalled = false
    
    var loadCategoriesReturnValue: [CategoryApiDto]!
    var loadCategoriesError: Error?
    var loadCategoriesCalled = false
    
    func loadAds() async throws -> [AdApiDto] {
        loadAdsCalled = true
        
        if let error = loadAdsError {
            throw error
        }
        
        return loadAdsReturnValue
    }
    
    func loadCategories() async throws -> [CategoryApiDto] {
        loadCategoriesCalled = true
        
        if let error = loadCategoriesError {
            throw error
        }
        
        return loadCategoriesReturnValue
    }
}
