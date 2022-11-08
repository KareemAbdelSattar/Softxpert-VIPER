//
//  RecipeDetailsVC.swift
//  Softxpert-VIPER
//
//  Created by kareem chetoos on 29/10/2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Kingfisher
import SafariServices

protocol RecipeDetailsViewProtocol: AnyObject {
    var presenter: RecipeDetailsPresenterProtocol? { get set }
    func updateView(recipe: Recipe)
}

class RecipeDetailsVC: UIViewController {
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var recipeWebsiteBtn: UIButton!
    var presenter: RecipeDetailsPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        configureUI()
        configureTableView()
        setuptShareButton()
        presenter?.viewDidLoad()
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "IngredientCell", bundle: nil), forCellReuseIdentifier: "IngredientCell")
    }
    
    private func setuptShareButton() {
        let share = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareButtonAction))
        navigationItem.rightBarButtonItem = share
    }
    
    @objc
    private func shareButtonAction() {
        guard let firstActivityItem = presenter?.recipe?.shareAs else { return }
        let activityViewController = UIActivityViewController(activityItems: [firstActivityItem], applicationActivities: nil)
        
        activityViewController.excludedActivityTypes = [
            UIActivity.ActivityType.postToFacebook,
            UIActivity.ActivityType.print,
            UIActivity.ActivityType.postToTwitter,
        ]
        
        DispatchQueue.main.async { [weak self] in
            self?.present(activityViewController, animated: true, completion: nil)
        }
    }
    
    private func showTutorial(urlString: String) {
        if let url = URL(string: urlString) {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true
            
            let vc = SFSafariViewController(url: url, configuration: config)
            DispatchQueue.main.async { [weak self] in
                self?.present(vc, animated: true)
            }
        }
    }
    
    private func configureUI() {
        recipeWebsiteBtn.layer.cornerRadius = 10
    }
    
    @IBAction func recipeWebsiteDidPressed(_ sender: Any) {
        guard let url = presenter?.recipe?.url else { return }
        showTutorial(urlString: url)
    }
}

extension RecipeDetailsVC: RecipeDetailsViewProtocol {
    func updateView(recipe: Recipe) {
        guard let url = try? recipe.image?.asURL() else { return }
        recipeImageView.kf.setImage(with: url)
        titleLabel.text = recipe.label
        title = presenter?.recipe?.label
    }
}

extension RecipeDetailsVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.recipe?.ingredients?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell") as? IngredientCell else { return UITableViewCell() }
        cell.ingredientLabel.text = presenter?.recipe?.ingredients![indexPath.row].text
        return cell
    }
}
