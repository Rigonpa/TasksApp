//
//  AddTaskCoordinator.swift
//  TasksApp
//
//  Created by Ricardo González Pacheco on 22/04/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import UIKit

class AddTaskCoordinator: Coordinator {
    let presenter: UINavigationController
    var onTaskSuccessfullyAdded: (() -> Void)?
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    override func start() {
        let addTaskViewModel = AddTaskViewModel()
        let addTaskViewController = AddTaskViewController(viewModel: addTaskViewModel)
        
        addTaskViewModel.coordinatorDelegate = self
        
        presenter.present(addTaskViewController, animated: true, completion: nil)
        
        
    }
    
    override func finish() {
        presenter.dismiss(animated: true, completion: nil)
    }
}

// MARK: - ViewModel communication
extension AddTaskCoordinator: AddTaskCoordinatorDelegate {
    func onNewTaskAdded() {
        // Closure to alert my coordinator parent that I am done:
        onTaskSuccessfullyAdded?()
    }
    
}
