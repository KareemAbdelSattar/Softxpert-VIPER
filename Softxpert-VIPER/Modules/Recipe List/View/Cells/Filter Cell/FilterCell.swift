//
//  FilterCell.swift
//  Softxpert-VIPER
//
//  Created by kareem chetoos on 27/10/2022.
//

import UIKit

class FilterCell: UICollectionViewCell {

    @IBOutlet weak var filterLabel: UILabel!
    
    var filterValue: String? {
        didSet {
            filterLabel.text = filterValue
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 10
        layer.masksToBounds = false
    }
}
