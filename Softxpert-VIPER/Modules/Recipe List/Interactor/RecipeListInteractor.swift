//
//  RecipeListInteractor.swift
//  Softxpert-VIPER
//
//  Created by kareem chetoos on 27/10/2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol RecipeListInteractorProtocol: AnyObject {
    var presenter: RecipeListPresenterProtocol? { get set }
    var remoteDataManager: RecipeListRemoteDataMangagerProtcol? { get set }
    func retriveRecipeList(searchText: String?, from: Int, to: Int, filter: String?)
    func onRecipesRetrieved(recipeModel: RecipesModel)
    func onError(error: FetchError)
    func retriveHistory()
    func saveHistory(searchText: String)
}

class RecipeListInteractor: RecipeListInteractorProtocol {

    weak var presenter: RecipeListPresenterProtocol?
    var remoteDataManager: RecipeListRemoteDataMangagerProtcol?
    var localDataManager: RecipeListLocalDataManagerProtocol?

    func retriveRecipeList(searchText: String?, from: Int, to: Int, filter: String?) {
        remoteDataManager?.retriveRecipeList(searchText: searchText!, filter: filter!, from: from, to: to)
    }
    
    func onRecipesRetrieved(recipeModel: RecipesModel) {
        if recipeModel.count == 0 {
            presenter?.didRetrieveError(error: .noRecipes)
        } else if recipeModel.hits == nil {
            presenter?.didRetrieveError(error: .emptyData)
        } else {
            presenter?.didRetrieveRecipes(hits: recipeModel.hits!)
        }
    }
    
    func onError(error: FetchError) {
        presenter?.didRetrieveError(error: .noRecipes)
    }
    
    func retriveHistory() {
        let history = try! localDataManager?.retrieveHistory()
        presenter?.didRetriveHistory(history: history!)
    }
    
    func saveHistory(searchText: String) {
       try! localDataManager?.saveHistory(searchText: searchText)
    }
}
