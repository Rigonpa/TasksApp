//
//  TasksListCoordinator.swift
//  TasksApp
//
//  Created by Ricardo González Pacheco on 22/04/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import UIKit

class TasksListCoordinator: Coordinator {
    
    let presenter: UINavigationController
    var tasksListViewModel: TasksListViewModel?
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    override func start() {
        
        let tasksListViewModel = TasksListViewModel()
        let tasksListViewController = TasksListViewController(viewModel: tasksListViewModel)
        
        tasksListViewModel.coordinatorDelegate = self
        tasksListViewModel.viewDelegate = tasksListViewController
        self.tasksListViewModel = tasksListViewModel // I had forgotten to inicialize this property
        
        presenter.pushViewController(tasksListViewController, animated: true)
    }
    
    override func finish() { }
}

// MARK: - ViewModel communication
extension TasksListCoordinator: TasksListCoordinatorDelegate {
    func onAddButtonSelected() {
        // Starting addTask module
        let addTaskCoordinator = AddTaskCoordinator(presenter: presenter)
        addChildCoordinator(addTaskCoordinator)
        addTaskCoordinator.start()
        
        // Closure from addTaskCoordinator to close that module
        addTaskCoordinator.onTaskSuccessfullyAdded = {[weak self] in
            guard let self = self else { return }
            
            self.tasksListViewModel?.fetchTasksFromLocalDatabase()
            addTaskCoordinator.finish()
            self.removeChildCoordinator(addTaskCoordinator)
        }
    }
}
