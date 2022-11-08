//
//  RemoteDataManagerMock.swift
//  Softxpert-VIPERTests
//
//  Created by kareem chetoos on 01/11/2022.
//

import XCTest
@testable import Softxpert_VIPER

class RecipeListRemoteDataManagerMock: RecipeListRemoteDataMangagerProtcol {
    var interactor: RecipeListInteractorProtocol?
    
    var error: FetchError?
    var recipeModel: RecipesModel!
    
    func retriveRecipeList(searchText: String, filter: String, from: Int, to: Int) {
        if error == nil {
            interactor?.onRecipesRetrieved(recipeModel: recipeModel)
        } else {
            interactor?.onError(error: error!)
        }
    }
}
