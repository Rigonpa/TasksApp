//
//  AddTaskViewModel.swift
//  TasksApp
//
//  Created by Ricardo González Pacheco on 22/04/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import Foundation

protocol AddTaskCoordinatorDelegate {
    func onNewTaskAdded()
}

protocol AddTaskViewDelegate {
    
}

class AddTaskViewModel {
    
    lazy var dataProvider: DataProvider = {
        let dataProvider = DataProvider()
        return dataProvider
    }()
    
    var coordinatorDelegate: AddTaskCoordinatorDelegate?
    var viewDelegate: AddTaskViewDelegate?
    
    func onSavingNewTask(title: String?) {
        guard let newTask = dataProvider.createTask() else { return }
        newTask.title = title
        newTask.state = TaskState.pending.rawValue
        dataProvider.saveTask()
        
        coordinatorDelegate?.onNewTaskAdded()
    }
}
