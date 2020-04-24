//
//  DataProvider.swift
//  TasksApp
//
//  Created by Ricardo González Pacheco on 22/04/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import Foundation

class DataProvider {
    
    // Variable de un protocolo
    let localDataProvider: LocalDataProvider // LocalDataProvider is parent
    
    init() {
        localDataProvider = DatabaseCoreData() // DatabaseCoreData is LocalDataProvider's child
    }
    
    func createTask() -> Task? {
        return localDataProvider.create()
    }
    
    func saveTask() {
        localDataProvider.persist()
    }
    
    func loadAllTasks() -> [Task]? {
        return localDataProvider.fetch()
    }
    
    func deleteTask(title: String) {
        localDataProvider.delete(title: title)
    }
    
    func deleteAllTasks() {
        localDataProvider.deleteAll()
    }
}
