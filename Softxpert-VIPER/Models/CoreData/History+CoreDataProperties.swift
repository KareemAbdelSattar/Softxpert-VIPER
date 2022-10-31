//
//  History+CoreDataProperties.swift
//  
//
//  Created by kareem chetoos on 29/10/2022.
//
//

import Foundation
import CoreData


extension History {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<History> {
        return NSFetchRequest<History>(entityName: "History")
    }

    @NSManaged public var suggestion: String?
    @NSManaged public var date: Date?
}
