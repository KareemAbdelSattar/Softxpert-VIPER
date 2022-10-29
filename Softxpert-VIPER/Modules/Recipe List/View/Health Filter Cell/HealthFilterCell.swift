//
//  CategoriesCell.swift
//  Softxpert
//
//  Created by Kareemchetoos on 6/10/21.
//

import UIKit

class HealthFilterCell: UICollectionViewCell {
    
    // MARK: - Properties
    @IBOutlet weak var filterLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    // MARK: - Instance Properties
    var healthText: String? {
        didSet{
            guard let data = healthText else { return }
            filterLabel.text = data
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = self.frame.height / 4
    }
}
