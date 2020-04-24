//
//  DataProviderTests.swift
//  TasksApp
//
//  Created by Ricardo González Pacheco on 23/04/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import Foundation

extension TasksListViewModel {
    
    /** Testing data provider
     
    func testingDatabase() {
//        createAndSaveNewTasks()
        showTasksSaved()
        print("\n\n")
        deleteTask()
        showTasksSaved()
    }
    
//    private func createAndSaveNewTasks() {
//        guard let newTask1 = dataProvider.createTask() else { return }
//        newTask1.title = "Task1"
//        newTask1.state = TaskState.pending.rawValue
//        guard let newTask2 = dataProvider.createTask() else { return }
//        newTask2.title = "Task2"
//        newTask2.state = TaskState.done.rawValue
//
//        dataProvider.saveTask()
//    }
    
    private func showTasksSaved() {
        let allTasks = dataProvider.loadAllTasks()
        print(allTasks!)
    }
    
    private func deleteTask() {
//        dataProvider.deleteTask(title: "Task1")
//        dataProvider.deleteTask(title: "Task2")
        dataProvider.deleteAllTasks()
    }
    
    

    
    // Testing tableView methods - Code inside fetchTasksFromLocalDatabase function
     
    guard let taskA = dataProvider.createTask() else { return }
    taskA.title = "TaskA"
    taskA.state = TaskState.pending.rawValue
     
    guard let taskB = dataProvider.createTask() else { return }
    taskB.title = "taskB"
    taskB.state = TaskState.pending.rawValue
     
    guard let taskC = dataProvider.createTask() else { return }
    taskC.title = "taskC"
    taskC.state = TaskState.pending.rawValue
    
    taskViewModels.append([TaskCellViewModel(task: taskA),
                           TaskCellViewModel(task: taskB),
                           TaskCellViewModel(task: taskC)]
     
    */
    
}
