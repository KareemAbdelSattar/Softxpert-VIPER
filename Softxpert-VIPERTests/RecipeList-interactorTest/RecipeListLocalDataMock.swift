//
//  RecipeListLocalDataMock.swift
//  Softxpert-VIPERTests
//
//  Created by kareem chetoos on 31/10/2022.
//

import XCTest
@testable import Softxpert_VIPER

class RecipeListLocalDataMock: RecipeListLocalDataManagerProtocol {
    var history = [History]()
    var searchText = ""
    var error: FetchError?

    func retrieveHistory() throws -> [History] {
        if error == nil {
            return history
        } else {
            throw error!
        }
    }
    
    func saveHistory(searchText: String) throws {
        if error == nil{
            self.searchText = searchText
            history = [History(),History(), History()]
        } else {
            throw error!
        }
    }
}
