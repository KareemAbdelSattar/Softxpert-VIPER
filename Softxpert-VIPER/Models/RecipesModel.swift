import Foundation
struct RecipesModel : Codable {
	let q : String?
	let from : Int?
	let to : Int?
	let more : Bool?
	let count : Int?
	let hits : [Hits]?

}
