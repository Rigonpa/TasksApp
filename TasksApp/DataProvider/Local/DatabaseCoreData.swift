//
//  DatabaseCoreData.swift
//  TasksApp
//
//  Created by Ricardo González Pacheco on 22/04/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import UIKit
import CoreData

final class DatabaseCoreData: LocalDataProvider {
    
    private var taskEntity = "Task"
    private var taskTitle = "title"
    private var taskState = "state"
    
    private var context: NSManagedObjectContext {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { fatalError() }
        return appDelegate.persistentContainer.viewContext
    }
    
    // Creating new task -> ONLY IN CONTEXT BUT NOT IN COREDATA
    func create() -> Task? {
        guard let entity = NSEntityDescription.entity(forEntityName: taskEntity, in: context) else { return nil }
        return Task(entity: entity, insertInto: context)
    }
    
    // Persist new task in coredata database
    func persist() {
        
        /** If I create this object I am duplicating the task object as in createTask method I already create the task object
         in the context, so just persist()
         
        guard let entity = NSEntityDescription.entity(forEntityName: taskEntity, in: context) else { return }
        let task = NSManagedObject(entity: entity, insertInto: context)
        task.setValue(data.title, forKey: taskTitle)
        task.setValue(data.state, forKey: taskState)
        */
        
        try? context.save()
    }
    
    // Loading all tasks saved in coredata database
    func fetch() -> [Task]? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: taskEntity)
        let tasksSaved = try? context.fetch(fetchRequest) as? [Task]
        return tasksSaved
    }
    
    // Deleting task from coredata database
    func delete(title: String) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: taskEntity)
        fetchRequest.predicate = NSPredicate(format: "title = %@", title)
        let taskToDelete = try? context.fetch(fetchRequest)
        taskToDelete?.forEach{ context.delete($0) }
        
        try? context.save()
    }
    
    // Deleting all tasks from coredata database
    func deleteAll() {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: taskEntity)
        let taskToDelete = try? context.fetch(fetchRequest)
        taskToDelete?.forEach{ context.delete($0) }
        
        try? context.save()
    }
}
