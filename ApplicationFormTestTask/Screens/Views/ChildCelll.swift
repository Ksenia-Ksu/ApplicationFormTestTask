//
//  ParentCell.swift
//  ApplicationFormTestTask
//
//  Created by Ксения Кобак on 24.10.2022.
//

import UIKit

final class ChildCell: UITableViewCell {
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: CellIDs.childCell)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    private let viewName = CustomView()
    
    private let viewAge = CustomView()
    
    private let nameLabel = CustomLabel(labelText: Text.nameLabel, color: .lightGray, customFont: Fonts.labels)
    
    let nameInputTextField = CustomTextField()
    
    private let ageLabel = CustomLabel(labelText: Text.ageLabel, color: .lightGray, customFont: Fonts.labels)
    
    let ageInputTextField = CustomTextField()
    
    let deleteButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.title = Text.deleteButton
        config.titleTextAttributesTransformer =
        UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = Fonts.buttonsTitle
            return outgoing
        }
        config.baseBackgroundColor = .blue
        config.titleAlignment = .leading
        let deleteButton = UIButton(configuration: config)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        return deleteButton
    }()
    
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        nameInputTextField.delegate = self
        ageInputTextField.delegate = self
        contentView.addSubview(viewName)
        contentView.addSubview(viewAge)
        contentView.addSubview(deleteButton)
        viewName.addSubview(nameLabel)
        viewName.addSubview(nameInputTextField)
        viewAge.addSubview(ageLabel)
        viewAge.addSubview(ageInputTextField)
        setupConstaints()
    }
    
    
    private func setupConstaints() {
        
        NSLayoutConstraint.activate([
            
            viewName.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor, constant: 5),
            viewName.leftAnchor.constraint(equalTo: self.layoutMarginsGuide.leftAnchor, constant: 0),
            viewName.rightAnchor.constraint(equalTo: deleteButton.leftAnchor, constant: 10),
            
            nameLabel.topAnchor.constraint(equalTo: viewName.topAnchor, constant: 5),
            nameLabel.leftAnchor.constraint(equalTo: viewName.leftAnchor, constant: 5),
            nameLabel.rightAnchor.constraint(equalTo: viewName.rightAnchor, constant: -5),
            
            
            nameInputTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2),
            nameInputTextField.leftAnchor.constraint(equalTo: viewName.leftAnchor, constant: 5),
            nameInputTextField.rightAnchor.constraint(equalTo: viewName.rightAnchor, constant: -5 ),
            nameInputTextField.bottomAnchor.constraint(equalTo: viewName.bottomAnchor, constant: -5 ),
            
            deleteButton.heightAnchor.constraint(equalToConstant: 30),
            deleteButton.widthAnchor.constraint(equalToConstant: 100),
            deleteButton.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor, constant: 5),
            deleteButton.rightAnchor.constraint(equalTo: self.layoutMarginsGuide.rightAnchor, constant: 0),
            
            viewAge.leftAnchor.constraint(equalTo: self.layoutMarginsGuide.leftAnchor, constant: 0),
            viewAge.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor, constant: -5),
            viewAge.rightAnchor.constraint(equalTo: deleteButton.leftAnchor, constant: 10),
            
            ageLabel.topAnchor.constraint(equalTo: viewAge.topAnchor, constant: 5),
            ageLabel.leftAnchor.constraint(equalTo: viewAge.leftAnchor, constant: 5),
            
            ageInputTextField.topAnchor.constraint(equalTo: ageLabel.bottomAnchor, constant: 2),
            ageInputTextField.leftAnchor.constraint(equalTo: viewAge.leftAnchor, constant: 5),
            ageInputTextField.rightAnchor.constraint(equalTo: viewAge.rightAnchor, constant: -5 ),
            ageInputTextField.bottomAnchor.constraint(equalTo: viewAge.bottomAnchor, constant: -5 ),
            
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        nameInputTextField.text = ""
        ageInputTextField.text = ""
        
    }
}

extension ChildCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
        
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == ageInputTextField {
            textField.keyboardType = .numberPad
        }
        return true
    }
}

