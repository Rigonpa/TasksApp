//
//  AppCoordinator.swift
//  TasksApp
//
//  Created by Ricardo González Pacheco on 22/04/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
    
    let window: UIWindow
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() {
        
        let tasksListNavigationController = UINavigationController()
        let tasksListCoordinator = TasksListCoordinator(presenter: tasksListNavigationController)
        addChildCoordinator(tasksListCoordinator)
        tasksListCoordinator.start()
        
        window.rootViewController = tasksListNavigationController
        window.makeKeyAndVisible()
        
    }
    
    override func finish() { }
}
