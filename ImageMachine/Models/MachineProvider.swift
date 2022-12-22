//
//  MachineProvider.swift
//  ImageMachine
//
//  Created by Yogi Priyo Prayogo on 20/12/22.
//

import CoreData

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
    
    func deleteImage(_ imageId: Int, completion: @escaping() -> Void) {
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ImageItem")
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "imageId == \(imageId)")

            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            batchDeleteRequest.resultType = .resultTypeCount

            if let batchDeleteResult = try? taskContext.execute(batchDeleteRequest) as? NSBatchDeleteResult {
                if batchDeleteResult.result != nil {
                    completion()
                }
            }
        }
    }
    
    func deleteMachine(_ id: Int, completion: @escaping() -> Void) {
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MachineItem")
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "id == \(id)")

            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            batchDeleteRequest.resultType = .resultTypeCount

            if let batchDeleteResult = try? taskContext.execute(batchDeleteRequest) as? NSBatchDeleteResult {
                if batchDeleteResult.result != nil {
                    completion()
                }
            }
        }
    }
    
    func getAllMachines(completion: @escaping(_ members: [Machine]) -> Void) {
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "MachineItem")
            do {
                let results = try taskContext.fetch(fetchRequest)
                var machineList: [Machine] = []
                for result in results {
                    let machine = Machine(
                        id: Int(result.value(forKeyPath: "id") as? Int32 ?? 0),
                        name: result.value(forKeyPath: "name") as? String ?? "",
                        type: result.value(forKeyPath: "type") as? String ?? "",
                        lastUpdated: result.value(forKeyPath: "lastUpdated") as? Date ?? Date(),
                        codeNumber: Int(result.value(forKeyPath: "codeNumber") as? Int32 ?? 0)
                    )

                    machineList.append(machine)
                }
                completion(machineList)
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }
    }
    
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
    
    func addImage(imageData: Data, machineId: Int, imageId: Int, completion: @escaping() -> Void) {
        let taskContext = newTaskContext()
        taskContext.performAndWait {
            if let entity = NSEntityDescription.entity(forEntityName: "ImageItem", in: taskContext) {
                let machine = NSManagedObject(entity: entity, insertInto: taskContext)
                machine.setValue(machineId, forKeyPath: "machineId")
                machine.setValue(imageData, forKeyPath: "imageData")
                machine.setValue(imageId, forKeyPath: "imageId")
                
                do {
                    try taskContext.save()
                    completion()
                } catch let error as NSError {
                    print("Could not save. \(error), \(error.userInfo)")
                }
            }
        }
    }
    
    func getMachine(_ codeNumber: Int, completion: @escaping(_ machineData: Machine) -> Void) {
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "MachineItem")
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "codeNumber == \(codeNumber)")
            do {
                if let result = try taskContext.fetch(fetchRequest).first {
                    let machineData = Machine(
                        id: Int(result.value(forKeyPath: "id") as? Int32 ?? 0),
                        name: result.value(forKeyPath: "name") as? String ?? "",
                        type: result.value(forKeyPath: "type") as? String ?? "",
                        lastUpdated: result.value(forKeyPath: "lastUpdated") as? Date ?? Date(),
                        codeNumber: Int(result.value(forKeyPath: "codeNumber") as? Int32 ?? 0)
                    )
                    completion(machineData)
                } else {
                    let emptyShellMachineData = Machine(id: 0, name: "not found", type: "", lastUpdated: Date(), codeNumber: 0)
                    completion(emptyShellMachineData)
                }
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }
    }

    func getMachineImages(_ machineId: Int, completion: @escaping(_ machineImage: [Data], _ imageIds: [Int]) -> Void) {
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ImageItem")
            fetchRequest.predicate = NSPredicate(format: "machineId == \(machineId)")
            do {
                let results = try taskContext.fetch(fetchRequest)
                var dataList: [Data] = []
                var idList: [Int] = []
                for data in results {
                    dataList.append(data.value(forKey: "imageData") as! Data)
                    idList.append(data.value(forKey: "imageId") as? Int ?? 0)
                }
                completion(dataList, idList)
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }
    }
}
