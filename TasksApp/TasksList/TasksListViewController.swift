//
//  TasksListViewController.swift
//  TasksApp
//
//  Created by Ricardo González Pacheco on 22/04/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import UIKit
import Lottie

class TasksListViewController: UIViewController {
    
    // MARK: - UI Elements
    lazy var segmentedControl: UISegmentedControl = {
        let sg = UISegmentedControl(items: ["All", "Pending", "Done"])
        sg.translatesAutoresizingMaskIntoConstraints = false
        sg.selectedSegmentIndex = 0
        sg.addTarget(self, action: #selector(handleSegmentedControlChange), for: .valueChanged)
        sg.isHidden = true
        return sg
    }()
    
    lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.isHidden = true
        tv.register(TaskCell.self, forCellReuseIdentifier: "CellId")
        tv.delegate = self
        tv.dataSource = self
//        tv.allowsMultipleSelectionDuringEditing = true
        tv.tableFooterView = UIView()
        return tv
    }()
    
    lazy var addButton: UIButton = {
        let btn = UIButton(type: .system)
        var addImage = UIImage(systemName: "plus")?.withRenderingMode(.alwaysTemplate)
        btn.setImage(addImage, for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.contentVerticalAlignment = .fill
        btn.contentHorizontalAlignment = .fill
        btn.tintColor = .black
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.isHidden = true
        btn.addTarget(self, action: #selector(handleAddTask), for: .touchUpInside)
        return btn
    }()
    
    let viewModel: TasksListViewModel
    init(viewModel: TasksListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecicle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        /** viewModel.testingDatabase() // Testing data provider */
        
        viewModel.fetchTasksFromLocalDatabase()
        
        view.addSubview(segmentedControl)
        view.addSubview(tableView)
        view.addSubview(addButton)
        
        startAnimation()
        
        NSLayoutConstraint.activate([
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            segmentedControl.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            segmentedControl.heightAnchor.constraint(equalToConstant: 32)
        ])
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 16),
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            addButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80),
            addButton.widthAnchor.constraint(equalToConstant: 50),
            addButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
    // MARK: - Private methods
    
    fileprivate func updateUI() {
        tableView.reloadData()
    }
    
    @objc private func handleSegmentedControlChange() {
        viewModel.fetchTasksFromLocalDatabase()
    }
    
    private func startAnimation() {
        let animationView = AnimationView(name: "LoadingLottie")
        view.addSubview(animationView)
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.loopMode = .repeat(1.0)
        animationView.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
        animationView.play {[weak self] (isFinished) in
            guard let self = self else { return }
            animationView.isHidden = true
            self.segmentedControl.isHidden = false
            self.tableView.isHidden = false
            self.addButton.isHidden = false
        }
        
        NSLayoutConstraint.activate([
            animationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animationView.heightAnchor.constraint(equalToConstant: 400)
        ])
    }
    
    @objc private func handleAddTask() {
        viewModel.handleAddTask()
    }
}

// MARK: - TableView methods
extension TasksListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(viewModel.heightForRow())
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(segmentedControlPosition: segmentedControl.selectedSegmentIndex)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath) as? TaskCell,
            let cellViewModel = viewModel.selectOneOfTheTaskViewModelsArray(indexPath: indexPath, segmentedControlPosition: segmentedControl.selectedSegmentIndex) else { fatalError() }
        cell.viewModel = cellViewModel // Here we join the cellviewmodel with the cell. In the rest of modules this joint
                                       // takes places in the module coordinator. For cell modules we do it in cellforrowat method
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
//    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        return true
//    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // This method allows me to drag in the task cell to the left and discover the red button "delete"
        viewModel.deleteTask(at: indexPath)
    }
    
    
}
// MARK: - ViewModel communication
extension TasksListViewController: TasksListViewDelegate {
    
    func onTasksFetched() {
        updateUI()
    }
}
