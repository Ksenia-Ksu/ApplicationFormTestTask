//
//  MainView.swift
//  ApplicationFormTestTask
//
//  Created by Ксения Кобак on 24.10.2022.
//

import UIKit

final class MainView: UIView {
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        setupViews()
        setupConstraint()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ChildCell.self, forCellReuseIdentifier: CellIDs.childCell)
        tableView.register(ParentCell.self, forCellReuseIdentifier: CellIDs.parentCell)
        tableView.separatorStyle = .singleLine
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    let cancelButton = CustomButton(title: Text.cancelButton, color: .systemRed, image: nil, font: Fonts.buttonsTitle)
    
    private func setupViews() {
        self.addTapGestureToHideKeyboard()
        self.addSubview(tableView)
        self.addSubview(cancelButton)
        
    }
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            tableView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
            tableView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: cancelButton.topAnchor, constant: -10),
            
            cancelButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
            cancelButton.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor, constant: -15)
            
        ])
    }
    
}
