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
    func getRecipes()
    func didRetrieveRecipes(hits: [Hits])
    func didRetrieveError(error: FetchError)
    func filter(with indexPath: IndexPath) -> String
    func recipe(with indexPath: IndexPath) -> Recipe?
    func fetchNextPage()
    func searchTextIsValidate(searchText: String) -> Bool
    func didSelectRecipe(indexPath: IndexPath)
    func didRetriveHistory(history: [History])
    func history(with indexPath: IndexPath) -> History
    func saveHistoryData(searchText: String)
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
    private var searchText = ""
    private var hits = [Hits]()
    private var history = [History]()

    func viewDidLoad() {
        view?.hideIndicator()
        view?.showError(with: "Empty recipes, Please enter search for recipe")
    }
    
    func showDetailsScreen(recipe: Recipe) {
        router?.pushToRecipeDetails(recipe: recipe)
    }
    
    func getRecipes() {
        from = 0
        to = 10
        hits.removeAll()
        view?.hideError()
        view?.showIndicator()
        interactor?.retriveRecipeList(searchText: searchText, from: from, to: to, filter: filterKeys[filterIndex.row])
    }
    
    func fetchNextPage() {
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
        hits.removeAll()
        self.view?.reloadCollection()
        switch error {
        case .failed:
            view?.showError(with: "Failed, Please try again")
        case .emptyData:
            if hits.isEmpty {
                view?.showError(with: "No Record, Please try again")
            }
        case .noRecipes:
            view?.showError(with: "Empty recipes, Please enter search for recipe")
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
    
    func saveHistoryData(searchText: String) {
        interactor?.saveHistory(searchText: searchText)
    }
    
    private func isValidateEnglishLetters(text: String) -> Bool {
        let Regex = "[a-z A-Z ]+"
        let predicate = NSPredicate.init(format: "SELF MATCHES %@", Regex)
        if predicate.evaluate(with: text) || text == "" {
            return true
        } else {
            return false
        }
    }
    
    func searchTextIsValidate(searchText: String) -> Bool {
        if !searchText.trimmingCharacters(in: .whitespaces).isEmpty, isValidateEnglishLetters(text: searchText){
            self.searchText = searchText
            return true
        } else {
            return false
        }
    }
}

