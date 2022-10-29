//
//  UIHelper.swift
//  Softxpert-VIPER
//
//  Created by kareem chetoos on 27/10/2022.
//

import UIKit

struct UIHelper {
    static func createProductCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { (section, environment) -> NSCollectionLayoutSection? in
            switch section {
            case 0 :
                return filterSection()
            case 1:
                return recipeSection()
            default:
                return recipeSection()
            }
        }
        return layout
    }
    
    static func filterSection() -> NSCollectionLayoutSection {
        //Item
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(0.6), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1/7))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
        group.interItemSpacing = .fixed(6)
        
        //Section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
    
    static func recipeSection() -> NSCollectionLayoutSection {
        //Item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)

        // Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(3/6))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        //Section
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
}
