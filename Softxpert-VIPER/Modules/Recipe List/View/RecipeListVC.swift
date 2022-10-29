//
//  RecipeListVC.swift
//  Softxpert-VIPER
//
//  Created by kareem chetoos on 27/10/2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol RecipeListViewProtocol: AnyObject {
    var presenter: RecipeListPresenterProtocol? { get set }
    func showIndicator()
    func hideIndicator()
    func reloadCollection()
    func reloadTableView()
    func showError(with msg: String)
    func hideError()
}

class RecipeListVC: UIViewController {
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    var presenter: RecipeListPresenterProtocol?
    private lazy var searchController: UISearchController = {
        let sc = UISearchController(searchResultsController: nil)
        sc.searchBar.delegate = self
        sc.obscuresBackgroundDuringPresentation = false
        sc.searchBar.placeholder = "Enter recipe name or food ingredient"
        return sc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureTableView()
        configureNavigationBar()
        presenter?.viewDidLoad()
        
    }
    
    private func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "FilterCell", bundle: nil), forCellWithReuseIdentifier: "FilterCell")
        collectionView.register(UINib(nibName: "RecipeCell", bundle: nil), forCellWithReuseIdentifier: "RecipeCell")
        collectionView.collectionViewLayout = UIHelper.createProductCompositionalLayout()
    }
    
    private func configureTableView() {
        searchTableView.delegate = self
        searchTableView.dataSource = self
    }
    
    private func configureNavigationBar() {
        title = "Recipe Search"
        navigationItem.searchController = searchController
    }
}

extension RecipeListVC: RecipeListViewProtocol {
    func showError(with msg: String) {
        errorLabel.text = msg
        errorView.isHidden = false
    }
    
    func hideError() {
        errorView.isHidden = true
    }
    
    func reloadCollection() {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    func reloadTableView() {
        DispatchQueue.main.async { [weak self] in
            self?.searchTableView.reloadData()
            self?.tableViewHeight.constant = (self?.searchTableView.contentSize.height)!
        }
    }
    
    func showIndicator() {
        loadingView.isUserInteractionEnabled = false
        loadingView.startAnimating()
    }
    
    func hideIndicator() {
        loadingView.isUserInteractionEnabled = true
        loadingView.stopAnimating()
    }
}

// MARK: - CollectionView Delegate - Datasource
extension RecipeListVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? presenter?.filterCount ?? 0 : presenter?.recipeCount ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let filterCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterCell", for: indexPath) as? FilterCell else { return UICollectionViewCell() }
            filterCell.filterValue = presenter?.filter(with: indexPath)
            filterCell.layer.backgroundColor = presenter?.filterIndex == indexPath ? UIColor.systemGray4.cgColor : UIColor.systemGray6.cgColor
            return filterCell
        case 1:
            guard let recipeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecipeCell", for: indexPath) as? RecipeCell else { return UICollectionViewCell() }
            recipeCell.recipe = presenter?.recipe(with: indexPath)
            return recipeCell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            self.collectionView(self.collectionView, didDeselectItemAt: presenter!.filterIndex)
            let cell = collectionView.cellForItem(at: indexPath) as? FilterCell
            cell?.backgroundColor = .systemGray4
            presenter!.filterIndex = indexPath
            presenter?.getRecipes()
        case 1:
            presenter?.didSelectRecipe(indexPath: indexPath)
        default:
            break
        }
    }
 
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            let cell = collectionView.cellForItem(at: indexPath) as? FilterCell
            cell?.backgroundColor = .systemGray6
        default:
            break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == presenter!.recipeCount - 1{
            presenter?.fetchNextPage()
        }
    }
}

// MARK: - UISearchBarDelegate
extension RecipeListVC: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        presenter?.getHistoryData()
        searchTableView.isHidden = false
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchTableView.isHidden = true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        if let searchText = searchBar.text, presenter!.searchTextIsValidate(searchText: searchText) {
            presenter?.saveHistoryData(searchText: searchText)
            presenter?.getRecipes()
        }
        
    }
}

// MARK: - CollectionView Delegate - Datasource
extension RecipeListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.historyCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchTableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = presenter?.history(with: indexPath).suggestion
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let history = presenter?.history(with: indexPath)
        searchController.searchBar.text = history?.suggestion
        tableView.isHidden = true
    }
}
