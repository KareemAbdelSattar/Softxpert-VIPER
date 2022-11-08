//
//  RecipeListPresenterMock.swift
//  Softxpert-VIPERTests
//
//  Created by kareem chetoos on 31/10/2022.
//

import XCTest
@testable import Softxpert_VIPER

class RecipeListPresenterMock: RecipeListPresenterProtocol {
    var view: RecipeListViewProtocol?
    
    var interactor: RecipeListInteractorProtocol?
    
    var router: RecipeListRouterProtocol?
    
    var filterCount: Int = 0
    
    var recipeCount: Int = 0
    
    var history = [History]()

    var historyCount: Int{
         self.history.count
    }
    
    var filterIndex: IndexPath = IndexPath(row: 0, section: 0)
    var error: FetchError?
    
    func viewDidLoad() {
        
    }
    
    func getRecipes(searchText: String) {
        
    }
    
    func didRetrieveRecipes(hits: [Hits]) {
        
    }
    
    func didRetrieveError(error: FetchError) {
        XCTAssertEqual(self.error, error)
    }
    
    func filter(with indexPath: IndexPath) -> String {
        return "data"
    }
    
    func recipe(with indexPath: IndexPath) -> Recipe? {
        return Recipe(uri: "", label: "", image: "", source: "", url: "", shareAs: "", healthLabels: [], ingredientLines: [], ingredients: [])
    }
    
    func fetchNextPage(searchText: String) {
        
    }
    
    func didSelectRecipe(indexPath: IndexPath) {
        
    }
    
    func didRetriveHistory(history: [History]) {
        self.history = history
    }
    
    func history(with indexPath: IndexPath) -> History {
        return history[indexPath.row]
    }
    
    func saveHistoryData(searchText: String) {

    }
    
    func getHistoryData() {
        
    }
    
    
}
