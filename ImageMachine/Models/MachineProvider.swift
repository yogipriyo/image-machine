//
//  MachineProvider.swift
//  ImageMachine
//
//  Created by Yogi Priyo Prayogo on 20/12/22.
//

import CoreData
//import UIKit

class MachineProvider {
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ImageMachine")

        container.loadPersistentStores { _, error in
            guard error == nil else {
                fatalError("Unresolved error \(error!)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = false
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.shouldDeleteInaccessibleFaults = true
        container.viewContext.undoManager = nil

        return container
        }()
    
    private func newTaskContext() -> NSManagedObjectContext {
        let taskContext = persistentContainer.newBackgroundContext()
        taskContext.undoManager = nil

        taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return taskContext
    }
    
//    func deleteAllFavorites(completion: @escaping() -> Void) {
//        let taskContext = newTaskContext()
//        taskContext.perform {
//            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "GameItem")
//            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
//            batchDeleteRequest.resultType = .resultTypeCount
//
//            if let batchDeleteResult = try? taskContext.execute(batchDeleteRequest) as? NSBatchDeleteResult {
//                if batchDeleteResult.result != nil {
//                    completion()
//                }
//            }
//        }
//    }
//
//    func deleteFavorite(_ id: Int, completion: @escaping() -> Void) {
//        let taskContext = newTaskContext()
//        taskContext.perform {
//            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "GameItem")
//            fetchRequest.fetchLimit = 1
//            fetchRequest.predicate = NSPredicate(format: "id == \(id)")
//
//            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
//            batchDeleteRequest.resultType = .resultTypeCount
//
//            if let batchDeleteResult = try? taskContext.execute(batchDeleteRequest) as? NSBatchDeleteResult {
//                if batchDeleteResult.result != nil {
//                    completion()
//                }
//            }
//        }
//    }
    
//    func getAllFavorites(completion: @escaping(_ members: [GameDetails]) -> Void) {
//        let taskContext = newTaskContext()
//        taskContext.perform {
//            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "GameItem")
//            do {
//                let results = try taskContext.fetch(fetchRequest)
//                var gameList: [GameDetails] = []
//                for result in results {
//                    let game = GameDetails(
//                        id: Int(result.value(forKeyPath: "id") as? Int32 ?? 0),
//                        slug: result.value(forKeyPath: "slug") as? String ?? "",
//                        name: result.value(forKeyPath: "name") as? String ?? "",
//                        description: result.value(forKeyPath: "description") as? String ?? "",
//                        platforms: [], stores: [],
//                        released: result.value(forKeyPath: "released") as? String ?? "",
//                        backgroundImage: result.value(forKeyPath: "backgroundImage") as? String ?? "",
//                        rating: result.value(forKeyPath: "rating") as? Double ?? 0.0,
//                        ratingsCount: Int(result.value(forKeyPath: "ratingsCount") as? Int32 ?? 0)
//                    )
//
//                    gameList.append(game)
//                }
//                completion(gameList)
//            } catch let error as NSError {
//                print("Could not fetch. \(error), \(error.userInfo)")
//            }
//        }
//    }
    
    func addMachine(_ machineData: Machine, completion: @escaping() -> Void) {
        let taskContext = newTaskContext()
        taskContext.performAndWait {
            if let entity = NSEntityDescription.entity(forEntityName: "MachineItem", in: taskContext) {
                let machine = NSManagedObject(entity: entity, insertInto: taskContext)
                machine.setValue(machineData.id, forKeyPath: "id")
                machine.setValue(machineData.name, forKeyPath: "name")
                machine.setValue(machineData.type, forKeyPath: "type")
                machine.setValue(machineData.lastUpdated, forKeyPath: "lastUpdated")
                machine.setValue(machineData.codeNumber, forKeyPath: "codeNumber")
                
                do {
                    try taskContext.save()
                    completion()
                } catch let error as NSError {
                    print("Could not save. \(error), \(error.userInfo)")
                }
            }
        }
    }

//    func getFavoriteDetails(_ id: Int, completion: @escaping(_ favDetails: GameDetails) -> Void) {
//        let taskContext = newTaskContext()
//        taskContext.perform {
//            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "GameItem")
//            fetchRequest.fetchLimit = 1
//            fetchRequest.predicate = NSPredicate(format: "id == \(id)")
//            do {
//                if let result = try taskContext.fetch(fetchRequest).first {
//                    let favorite = GameDetails(
//                        id: Int(result.value(forKeyPath: "id") as? Int32 ?? 0),
//                        slug: result.value(forKeyPath: "slug") as? String ?? "",
//                        name: result.value(forKeyPath: "name") as? String ?? "",
//                        description: result.value(forKeyPath: "description") as? String ?? "",
//                        platforms: [], stores: [],
//                        released: result.value(forKeyPath: "released") as? String ?? "",
//                        backgroundImage: result.value(forKeyPath: "backgroundImage") as? String ?? "",
//                        rating: result.value(forKeyPath: "rating") as? Double ?? 0.0,
//                        ratingsCount: Int(result.value(forKeyPath: "ratingsCount") as? Int32 ?? 0)
//                    )
//
//                    completion(favorite)
//                }
//        } catch let error as NSError {
//            print("Could not fetch. \(error), \(error.userInfo)")
//        }
//      }
//    }
}
