//
//  RecipeListLocalDataManager.swift
//  Softxpert-VIPER
//
//  Created by kareem chetoos on 29/10/2022.
//


import CoreData

enum PersistenceError: Error {
    case managedObjectContextNotFound
    case couldNotSaveObject
    case objectNotFound
}

protocol RecipeListLocalDataManagerProtocol: AnyObject {
    func retrieveHistory() throws -> [History]
    func saveHistory(searchText: String) throws
}

class RecipeListLocalDataManager: RecipeListLocalDataManagerProtocol {
    func saveHistory(searchText: String) throws {
        guard let managedOC = CoreDataStore.managedObjectContext else {
            throw PersistenceError.managedObjectContextNotFound
        }
        
       if let newHistory = NSEntityDescription.insertNewObject(forEntityName: "History", into: managedOC) as? History{
           do {
               newHistory.suggestion = searchText
               newHistory.date = Date()
                try managedOC.save()
           }
          
        }
    }
    
    func retrieveHistory() throws -> [History]  {
        
        guard let managedOC = CoreDataStore.managedObjectContext else {
            throw PersistenceError.managedObjectContextNotFound
        }
        
        let request: NSFetchRequest<History> = NSFetchRequest(entityName: String(describing: History.self))
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        request.fetchLimit = 10
        return try managedOC.fetch(request)
    }
    
}
