//
//  RecipesModel.swift
//
//
//  Created by kareem chetoos on 29/10/2022.
//
//
import Foundation
struct RecipesModel : Codable {
	let q : String?
	let from : Int?
	let to : Int?
	let more : Bool?
	let count : Int?
	let hits : [Hits]?

}
