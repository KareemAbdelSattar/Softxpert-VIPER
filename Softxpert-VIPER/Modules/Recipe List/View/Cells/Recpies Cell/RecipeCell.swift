//
//  CourseCell.swift
//  Softxpert
//
//  Created by Kareemchetoos on 6/9/21.
//

import UIKit
import Kingfisher

class RecipeCell: UICollectionViewCell {
    
    // MARK: - Properties
    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var channelImageView: UIImageView!
    @IBOutlet weak var recipeLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var healthLabel: UILabel!
    
    // MARK: - Instance Properties
    var recipe: Recipe? {
        didSet {
            guard let recipe = self.recipe else { return }
            let url = try! recipe.image?.asURL()
            channelImageView.kf.indicatorType = .activity
            channelImageView.kf.setImage(with: url)
            recipeLabel.text = recipe.label
            sourceLabel.text = recipe.source
            healthLabel.text = recipe.healthLabels?.joined(separator: " - ")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func setupUI() {
        self.layer.cornerRadius = 15
        self.imageContainerView.layer.cornerRadius = 15
//        self.addShadow(ofColor: UIColor(patternImage: R.image.ceCover()!))
    }
}
