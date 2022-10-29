//
//  RecipeDetailsInteractor.swift
//  Softxpert-VIPER
//
//  Created by kareem chetoos on 29/10/2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol RecipeDetailsInteractorProtocol {
    var presenter: RecipeDetailsPresenterProtocol? { get set }

}

class RecipeDetailsInteractor: RecipeDetailsInteractorProtocol {

    var presenter: RecipeDetailsPresenterProtocol?

}
