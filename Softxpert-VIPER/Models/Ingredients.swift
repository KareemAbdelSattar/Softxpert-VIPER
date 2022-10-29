import Foundation
struct Ingredients : Codable {
	let text : String?
	let quantity : Double?
	let measure : String?
	let food : String?
	let weight : Double?
	let foodCategory : String?
	let foodId : String?
	let image : String?

	enum CodingKeys: String, CodingKey {

		case text = "text"
		case quantity = "quantity"
		case measure = "measure"
		case food = "food"
		case weight = "weight"
		case foodCategory = "foodCategory"
		case foodId = "foodId"
		case image = "image"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		text = try values.decodeIfPresent(String.self, forKey: .text)
		quantity = try values.decodeIfPresent(Double.self, forKey: .quantity)
		measure = try values.decodeIfPresent(String.self, forKey: .measure)
		food = try values.decodeIfPresent(String.self, forKey: .food)
		weight = try values.decodeIfPresent(Double.self, forKey: .weight)
		foodCategory = try values.decodeIfPresent(String.self, forKey: .foodCategory)
		foodId = try values.decodeIfPresent(String.self, forKey: .foodId)
		image = try values.decodeIfPresent(String.self, forKey: .image)
	}

}
