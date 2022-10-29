//
//  RecipeDetailsPresenter.swift
//  Softxpert-VIPER
//
//  Created by kareem chetoos on 29/10/2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation


protocol RecipeDetailsPresenterProtocol: AnyObject {
    var view: RecipeDetailsViewProtocol? { get set }
    var interactor: RecipeDetailsInteractorProtocol? { get set }
    var router: RecipeDetailsRouterProtocol? { get set }
    var recipe: Recipe? { get set }
    func viewDidLoad()
}

class RecipeDetailsPresenter: RecipeDetailsPresenterProtocol {
    weak var view: RecipeDetailsViewProtocol?
    var interactor: RecipeDetailsInteractorProtocol?
    var router: RecipeDetailsRouterProtocol?
    var recipe: Recipe?
    
    func viewDidLoad() {
        view?.updateView(recipe: recipe!)
    }
}

