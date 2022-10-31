//
//  Hits.swift
//
//
//  Created by kareem chetoos on 29/10/2022.
//
//
import Foundation
struct Hits : Codable {
	let recipe : Recipe?

	enum CodingKeys: String, CodingKey {

		case recipe = "recipe"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		recipe = try values.decodeIfPresent(Recipe.self, forKey: .recipe)
	}

}
