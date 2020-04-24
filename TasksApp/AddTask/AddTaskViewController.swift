//
//  AddTaskViewController.swift
//  TasksApp
//
//  Created by Ricardo González Pacheco on 22/04/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController {
    
    // MARK: - UIElements
    lazy var textField: UITextField = {
        let tf = UITextField(frame: .zero)
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.textAlignment = .center
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.darkGray.withAlphaComponent(0.2).cgColor
        tf.layer.cornerRadius = 16
        return tf
    }()
    
    lazy var label: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "New task"
        return label
    }()
    
    lazy var saveButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Add", for: .normal)
        btn.backgroundColor = .orange
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.textAlignment = .center
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.darkGray.withAlphaComponent(0.2).cgColor
        btn.layer.cornerRadius = 16
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(handleSaveTask), for: .touchUpInside)
        return btn
    }()
    
    let viewModel: AddTaskViewModel
    
    init(viewModel: AddTaskViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(textField)
        view.addSubview(label)
        view.addSubview(saveButton)

        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            textField.widthAnchor.constraint(equalToConstant: 300),
            textField.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.bottomAnchor.constraint(equalTo: textField.topAnchor, constant: -16),
            label.widthAnchor.constraint(equalToConstant: 200),
            label.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 16),
            saveButton.widthAnchor.constraint(equalToConstant: 80),
            saveButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    // MARK: - Private methods
    
    @objc private func handleSaveTask() {
        viewModel.onSavingNewTask(title: textField.text)
    }
    
}

// MARK: - ViewModel communication
extension AddTaskViewController: AddTaskViewDelegate {
    
}
