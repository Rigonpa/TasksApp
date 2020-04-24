//
//  TaskCell.swift
//  TasksApp
//
//  Created by Ricardo González Pacheco on 23/04/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import UIKit

protocol TaskCellViewDelegate {
    
}

protocol TaskCellViewModelDelegate {
    func onStateChange(to: Bool, title: String)
}

class TaskCellViewModel {
    
    lazy var dataProvider: DataProvider = {
        let dataProvider = DataProvider()
        return dataProvider
    }()
    
    let task: Task
    var delegate: TaskCellViewModelDelegate?
    
    init(task: Task) {
        self.task = task
    }
    
    func onStateChange(to state: Bool, title: String) {
        self.delegate?.onStateChange(to: state, title: title)
    }
    
    
    
}
