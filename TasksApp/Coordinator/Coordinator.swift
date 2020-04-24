//
//  Coordinator.swift
//  TasksApp
//
//  Created by Ricardo González Pacheco on 22/04/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import Foundation

class Coordinator {
    
    fileprivate var childCoordinators = [Coordinator]()
    
    func start() {
        preconditionFailure("This method has to be overriden by subclass")
    }
    
    func finish() {
        preconditionFailure("This method has to be overriden by subclass")
    }
    
    func addChildCoordinator(_ coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }
    
    func removeChildCoordinator(_ coordinator: Coordinator) {
        if let index = childCoordinators.firstIndex(of: coordinator) {
            childCoordinators.remove(at: index)
        } else {
            print("Not possible to delete this child coordinator: \(coordinator)")
        }
    }
    
    func removeAllChildCoordinatorsWith<T>(type: T.Type) {
        childCoordinators = childCoordinators.filter{ $0 is T == false}
    }
    
    func removeAllChildCoordinators() {
        childCoordinators.removeAll()
    }
    
}

extension Coordinator: Equatable {
    static func == (lhs: Coordinator, rhs: Coordinator) -> Bool {
        return lhs === rhs
    }
    
    
}
