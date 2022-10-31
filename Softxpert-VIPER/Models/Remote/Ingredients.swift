//
//  Ingredients.swift
//
//
//  Created by kareem chetoos on 29/10/2022.
//
//
import Foundation
struct Ingredients : Codable {
	let text : String?
	let quantity : Double?


	enum CodingKeys: String, CodingKey {

		case text = "text"
		case quantity = "quantity"
	}
}
