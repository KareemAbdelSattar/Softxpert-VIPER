//
//  RecipeListRemoteDataManger.swift
//  Softxpert-VIPER
//
//  Created by kareem chetoos on 27/10/2022.
//

import Foundation

protocol RecipeListRemoteDataMangagerProtcol: AnyObject {
    var interactor: RecipeListInteractorProtocol? { get set }
    func retriveRecipeList(searchText: String, filter: String, from: Int, to: Int)
}

class RecipeListRemoteDataMangager: RecipeListRemoteDataMangagerProtcol {
   weak var interactor: RecipeListInteractorProtocol?
    
    func retriveRecipeList(searchText: String , filter: String, from: Int, to: Int) {
        NetworkService.shared.fetch(userRouter: RecipeRouter.recipes(searchText: searchText, filter: filter, from: from, to: to)) { [weak self] (result: Result<RecipesModel?, FetchError>) in
            switch result {
            case .success(let success):
                if let recipeModel = success {
                    self?.interactor?.onRecipesRetrieved(recipeModel: recipeModel)
                }
            case .failure:
                self?.interactor?.onError(error: .failed)
            }
            
        }
    }
}
