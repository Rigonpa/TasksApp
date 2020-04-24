//
//  TasksListViewModel.swift
//  TasksApp
//
//  Created by Ricardo González Pacheco on 22/04/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import Foundation

protocol TasksListCoordinatorDelegate {
    func onAddButtonSelected()
}

protocol TasksListViewDelegate {
    func onTasksFetched()
}

class TasksListViewModel {
    
    // MARK: - Public properties
    lazy var dataProvider: DataProvider = {
        let dataProvider = DataProvider()
        return dataProvider
    }()
    
    var viewDelegate: TasksListViewDelegate?
    var coordinatorDelegate: TasksListCoordinatorDelegate?
    
    var taskViewModels = [TaskCellViewModel]()
    var currentTaskViewModels = [TaskCellViewModel]()
    
    // MARK: - Public methods
    func deleteTask(at index: IndexPath) {
        guard index.row < taskViewModels.count else { return } // To avoid index out of range
        let taskVM = taskViewModels[index.row]
        guard let title = taskVM.task.title else { return }
        dataProvider.deleteTask(title: title)
        fetchTasksFromLocalDatabase()
    }
    
    func handleAddTask() {
        coordinatorDelegate?.onAddButtonSelected()
    }
    
    func onNewTaskWasCreated() {
        viewDelegate?.onTasksFetched()
    }
    
    func fetchTasksFromLocalDatabase() {
        taskViewModels = []
        guard let allTasks = dataProvider.loadAllTasks(), allTasks.isEmpty == false else {
            viewDelegate?.onTasksFetched()
            return
        }
        for each in 0...allTasks.count - 1 {
            let taskViewModel = TaskCellViewModel(task: allTasks[each])
            taskViewModel.delegate = self // I always forget this step. However it is a must. Please remember saying who is de TaskCellViewModel delegate!!!
            taskViewModels.append(taskViewModel)
        }
        viewDelegate?.onTasksFetched()
    }
    
    // MARK: - TableView methods
    func numberOfRows(segmentedControlPosition pos: Int) -> Int {
        
        currentTaskViewModels = []
        switch pos {
            
            // Pending position of the segmented control
            case 1:
                currentTaskViewModels = taskViewModels.filter{ $0.task.state == TaskState.pending.rawValue}
                return currentTaskViewModels.count
            
            // Done position of the segmented control
            case 2:
                currentTaskViewModels = taskViewModels.filter{ $0.task.state == TaskState.done.rawValue}
                return currentTaskViewModels.count
            
            //All position of the segmented control
            default:
                currentTaskViewModels = taskViewModels
                return currentTaskViewModels.count
        }
    }
    
    func selectOneOfTheTaskViewModelsArray(indexPath: IndexPath, segmentedControlPosition pos: Int) -> TaskCellViewModel? {
        
        guard indexPath.row < taskViewModels.count else { return nil}
        return currentTaskViewModels[indexPath.row]
    }
     
    func heightForRow() -> Int {
        return 50
    }
    
}

// MARK: - task cell view model communication
extension TasksListViewModel: TaskCellViewModelDelegate {
    func onStateChange(to state: Bool, title: String) {
        guard let allTasks = dataProvider.loadAllTasks(), allTasks.isEmpty == false else { return }
        
        let updatedTask = allTasks.filter{ $0.title == title }
        updatedTask.forEach {
            if state {
                $0.state = TaskState.done.rawValue
                print("Updating task state to done")
            } else {
                $0.state = TaskState.pending.rawValue
                print("Updating task state to pending")
            }
        }
        dataProvider.saveTask()
        fetchTasksFromLocalDatabase()
    }
}
