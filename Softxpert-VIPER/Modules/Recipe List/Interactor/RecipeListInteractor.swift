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
}

class RecipeListInteractor: RecipeListInteractorProtocol {
    
    weak var presenter: RecipeListPresenterProtocol?
    var remoteDataManager: RecipeListRemoteDataMangagerProtcol?
    var localDataManager: RecipeListLocalDataManagerProtocol?
    
    func retriveRecipeList(searchText: String?, from: Int, to: Int, filter: String?) {
        if let searchText = searchText, isValidWhiteSpaces(searchText: searchText), isValidateEnglishLetters(text: searchText) {
            remoteDataManager?.retriveRecipeList(searchText: searchText, filter: filter!, from: from, to: to)
            saveHistory(searchText: searchText)
        } else {
            presenter?.didRetrieveError(error: .textSearchInvalid)
        }
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
        presenter?.didRetrieveError(error: error)
    }
    
    func retriveHistory() {
        do {
            let history = try localDataManager?.retrieveHistory()
            presenter?.didRetriveHistory(history: history!)
        } catch (let error){
            presenter?.didRetrieveError(error: (error as? FetchError)!)
        }
    }
    
     func saveHistory(searchText: String) {
         do {
             try localDataManager?.saveHistory(searchText: searchText)
         } catch{
             presenter?.didRetrieveError(error: (error as? FetchError)!)
         }
    }
    
     func isValidateEnglishLetters(text: String) -> Bool {
        let Regex = "[a-z A-Z ]+"
        let predicate = NSPredicate.init(format: "SELF MATCHES %@", Regex)
        if predicate.evaluate(with: text) || text == "" {
            return true
        } else {
            return false
        }
    }
    
     func isValidWhiteSpaces(searchText: String) -> Bool {
        if !searchText.trimmingCharacters(in: .whitespaces).isEmpty{
            return true
        } else {
            return false
        }
    }
}
