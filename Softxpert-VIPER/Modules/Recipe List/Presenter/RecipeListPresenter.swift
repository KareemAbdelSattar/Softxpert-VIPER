//
//  RecipeListPresenter.swift
//  Softxpert-VIPER
//
//  Created by kareem chetoos on 27/10/2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation


protocol RecipeListPresenterProtocol: AnyObject {
    var view: RecipeListViewProtocol? { get set }
    var interactor: RecipeListInteractorProtocol? { get set }
    var router: RecipeListRouterProtocol? { get set }
    var filterCount: Int { get }
    var recipeCount: Int { get }
    var historyCount: Int { get }
    var filterIndex: IndexPath { get set }
    func viewDidLoad()
    func getRecipes(searchText: String)
    func didRetrieveRecipes(hits: [Hits])
    func didRetrieveError(error: FetchError)
    func filter(with indexPath: IndexPath) -> String
    func recipe(with indexPath: IndexPath) -> Recipe?
    func fetchNextPage(searchText: String)
    func didSelectRecipe(indexPath: IndexPath)
    func didRetriveHistory(history: [History])
    func history(with indexPath: IndexPath) -> History
    func getHistoryData()
}

class RecipeListPresenter: RecipeListPresenterProtocol {
   
    weak var view: RecipeListViewProtocol?
    var interactor: RecipeListInteractorProtocol?
    var router: RecipeListRouterProtocol?
    var filterIndex: IndexPath = IndexPath(item: 0, section: 0)
    var filterCount: Int {
        return filterValues.count
    }
    var recipeCount: Int {
        return hits.count
    }
    var historyCount: Int {
        return history.count
    }
    
    private let filterValues = [ "All",  "Low Sugar", "Vegan", "Keto Friendly"]
    private let filterKeys = ["", "low-sugar", "vegan", "keto-friendly"]
    private var from = 0
    private var to = 10
    private var hits = [Hits]()
    private var history = [History]()

    func viewDidLoad() {
        view?.hideIndicator()
        view?.showError(with: "Empty recipes, Please enter search for recipe")
    }
    
    func showDetailsScreen(recipe: Recipe) {
        router?.pushToRecipeDetails(recipe: recipe)
    }
    
    func getRecipes(searchText: String) {
        from = 0
        to = 10
        hits.removeAll()
        view?.hideError()
        view?.showIndicator()
        interactor?.retriveRecipeList(searchText: searchText, from: from, to: to, filter: filterKeys[filterIndex.row])
    }
    
    func fetchNextPage(searchText: String) {
        from = to
        to = to + 10
        view?.hideError()
        view?.showIndicator()
        interactor?.retriveRecipeList(searchText: searchText, from: from, to: to, filter: filterKeys[filterIndex.row])
    }
    
    func didRetrieveRecipes(hits: [Hits]) {
        self.hits.append(contentsOf: hits)
        view?.hideIndicator()
        view?.reloadCollection()
    }
    
    func didRetrieveError(error: FetchError) {
        view?.hideIndicator()
        switch error {
        case .failed:
            view?.showError(with: "Failed, Please try again")
            hits.removeAll()
            self.view?.reloadCollection()
        case .emptyData:
            if hits.isEmpty {
                view?.showError(with: "No Record, Please try again")
                hits.removeAll()
                self.view?.reloadCollection()
            }
        case .noRecipes:
            view?.showError(with: "Empty recipes, Please enter search for recipe")
            hits.removeAll()
            self.view?.reloadCollection()
        case .textSearchInvalid:
            print("Text Search Invalid")
        }
    }
    
    func filter(with indexPath: IndexPath) -> String {
        return filterValues[indexPath.row]
    }
    
    func recipe(with indexPath: IndexPath) -> Recipe? {
        return hits[indexPath.row].recipe
    }
    
    func didSelectRecipe(indexPath: IndexPath) {
        router?.pushToRecipeDetails(recipe: hits[indexPath.row].recipe!)
    }
    
    func didRetriveHistory(history: [History]) {
        self.history = history
        view?.reloadTableView()
    }
    
    func history(with indexPath: IndexPath) -> History {
        return history[indexPath.row]
    }
    
    func getHistoryData() {
        interactor?.retriveHistory()
    }
}

