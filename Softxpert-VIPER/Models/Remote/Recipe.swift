//
//  Recipe.swift
//
//
//  Created by kareem chetoos on 29/10/2022.
//
//
import Foundation

struct Recipe : Codable {
	let uri : String?
	let label : String?
	let image : String?
	let source : String?
	let url : String?
	let shareAs : String?
	let healthLabels : [String]?
	let ingredientLines : [String]?
	let ingredients : [Ingredients]?

	enum CodingKeys: String, CodingKey {
		case uri = "uri"
		case label = "label"
		case image = "image"
		case source = "source"
		case url = "url"
		case shareAs = "shareAs"
		case healthLabels = "healthLabels"
		case ingredientLines = "ingredientLines"
		case ingredients = "ingredients"
	}
}
