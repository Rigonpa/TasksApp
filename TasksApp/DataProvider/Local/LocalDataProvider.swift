//
//  PersistanceManager.swift
//  TasksApp
//
//  Created by Ricardo González Pacheco on 22/04/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import Foundation

protocol LocalDataProvider {
    func create() -> Task?
    func persist()
    func fetch() -> [Task]?
    func delete(title: String)
    func deleteAll()
}
