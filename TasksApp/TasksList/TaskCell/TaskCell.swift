//
//  TaskCellViewController.swift
//  TasksApp
//
//  Created by Ricardo González Pacheco on 23/04/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import UIKit

class TaskCell: UITableViewCell {
    
    // MARK: - UIElements
    lazy var title: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var stateSwitch: UISwitch = {
        let ss = UISwitch(frame: .zero)
        ss.translatesAutoresizingMaskIntoConstraints = false
        ss.isOn = false
        ss.addTarget(self, action: #selector(handleSwitchChange), for: .valueChanged)
        return ss
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
    }
    
    // MARK: - Public properties
    var viewModel: TaskCellViewModel? { // I can use this viewModel variable here in all places. I thought it only works inside didSet.
        didSet {
            guard let viewModel = viewModel else { return }
            title.text = viewModel.task.title
            if viewModel.task.state == 1 {   // case done
                stateSwitch.isOn = true
            } else {   // case pending
                stateSwitch.isOn = false
            }
            settingTaskCellUI()
        }
    }
    
    // MARK: - Private methods
    @objc private func handleSwitchChange() {
        guard let title = title.text else { return }
        viewModel?.onStateChange(to: stateSwitch.isOn, title: title)
    }
    
    private func settingTaskCellUI() {
        contentView.addSubview(title)
        contentView.addSubview(stateSwitch)
        
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            title.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            title.widthAnchor.constraint(equalToConstant: 300),
            title.heightAnchor.constraint(equalTo: contentView.heightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            stateSwitch.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 20),
            stateSwitch.centerYAnchor.constraint(equalTo: title.centerYAnchor),
            stateSwitch.widthAnchor.constraint(equalToConstant: 100),
            stateSwitch.heightAnchor.constraint(equalToConstant: 30)
        ])
        
//        contentView.layer.cornerRadius = 4.0
//        // Shadow
//        contentView.layer.shadowColor = UIColor.lightGray.cgColor
//        contentView.layer.shadowOffset = .zero
//        contentView.layer.shadowRadius = 4.0
//        contentView.layer.shadowOpacity = 0.2
    }
    
    override func prepareForReuse() {
        // Not necessary in this class
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Cell view model communication
extension TaskCell: TaskCellViewDelegate {
    
}
