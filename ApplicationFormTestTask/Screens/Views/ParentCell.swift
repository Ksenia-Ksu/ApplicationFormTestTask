//
//  ParentCell.swift
//  ApplicationFormTestTask
//
//  Created by Ксения Кобак on 25.10.2022.
//

import UIKit


final class ParentCell: UITableViewCell {
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: CellIDs.parentCell)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    
    let titleParent = CustomLabel(labelText: Text.headerParent, color: .black, customFont: Fonts.headerTitle)
    
    private let nameView = CustomView()
    
    private let nameLabel = CustomLabel(labelText: Text.nameLabel, color: .lightGray, customFont: Fonts.labels)
    
    let nameTF = CustomTextField()
    
    private let ageView = CustomView()
    
    private let ageLabel = CustomLabel(labelText: Text.ageLabel, color: .lightGray, customFont: Fonts.labels)
    
    let ageTF = CustomTextField()
    
    private let childrenLabel = CustomLabel(labelText: Text.headerChildren, color: .black, customFont: Fonts.headerTitle)
    
    let addButton = CustomButton(title: Text.addButton, color: .systemBlue, image: UIImage(systemName: "plus"), font: Fonts.buttonsTitle)
    
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        setupViews()
        setupConstaints()
    }
    
    private func setupViews() {
        self.addSubview(titleParent)
        self.addSubview(nameView)
        nameView.addSubview(nameLabel)
        nameView.addSubview(nameTF)
        self.addSubview(ageView)
        ageView.addSubview(ageLabel)
        ageView.addSubview(ageTF)
        self.addSubview(childrenLabel)
        self.addSubview(addButton)
        nameTF.delegate = self
        ageTF.delegate = self
    }
    
    private func setupConstaints() {
        
        NSLayoutConstraint.activate([
            titleParent.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor, constant: 15),
            titleParent.leftAnchor.constraint(equalTo: self.layoutMarginsGuide.leftAnchor, constant: 0),
            titleParent.rightAnchor.constraint(equalTo: self.layoutMarginsGuide.rightAnchor, constant: 0),
            
            nameView.topAnchor.constraint(equalTo: titleParent.bottomAnchor, constant: 10),
            nameView.leftAnchor.constraint(equalTo: self.layoutMarginsGuide.leftAnchor, constant: 0),
            nameView.rightAnchor.constraint(equalTo: self.layoutMarginsGuide.rightAnchor, constant: 0),
            
            nameLabel.leftAnchor.constraint(equalTo: nameView.leftAnchor, constant: 10),
            nameLabel.topAnchor.constraint(equalTo: nameView.topAnchor, constant: 5),
            
            nameTF.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            nameTF.leftAnchor.constraint(equalTo: nameView.leftAnchor, constant: 10),
            nameTF.rightAnchor.constraint(equalTo: nameView.rightAnchor, constant: -5),
            nameTF.bottomAnchor.constraint(equalTo: nameView.bottomAnchor, constant: -5),
            
            ageView.topAnchor.constraint(equalTo: nameView.bottomAnchor, constant: 15),
            ageView.leftAnchor.constraint(equalTo: self.layoutMarginsGuide.leftAnchor, constant: 0),
            ageView.rightAnchor.constraint(equalTo: self.layoutMarginsGuide.rightAnchor, constant: 0),
            
            ageLabel.leftAnchor.constraint(equalTo: ageView.leftAnchor, constant: 10),
            ageLabel.topAnchor.constraint(equalTo: ageView.topAnchor, constant: 5),
            
            ageTF.topAnchor.constraint(equalTo: ageLabel.bottomAnchor, constant: 5),
            ageTF.leftAnchor.constraint(equalTo: ageView.leftAnchor, constant: 10),
            ageTF.rightAnchor.constraint(equalTo: ageView.rightAnchor, constant: -5),
            ageTF.bottomAnchor.constraint(equalTo: ageView.bottomAnchor, constant: -5),
            
            addButton.topAnchor.constraint(equalTo: ageView.bottomAnchor, constant: 15),
            addButton.rightAnchor.constraint(equalTo: self.layoutMarginsGuide.rightAnchor, constant: 0),
            
            childrenLabel.topAnchor.constraint(equalTo: ageView.bottomAnchor, constant: 15),
            childrenLabel.leftAnchor.constraint(equalTo: self.layoutMarginsGuide.leftAnchor, constant: 0),
            childrenLabel.centerYAnchor.constraint(equalTo: addButton.centerYAnchor, constant: 0),
            
        ])
    }
    
}

extension ParentCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
        
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == ageTF {
            textField.keyboardType = .numberPad
        }
        return true
    }
}


