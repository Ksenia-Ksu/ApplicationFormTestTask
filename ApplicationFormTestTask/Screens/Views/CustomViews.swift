//
//  CustomViews.swift
//  ApplicationFormTestTask
//
//  Created by Ксения Кобак on 24.10.2022.
//

import UIKit

//MARK: - Label

final class CustomLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init(labelText: String, color: UIColor, customFont: UIFont) {
        super.init(frame: .zero)
        textAlignment = .left
        text = labelText
        textColor = color
        font = customFont
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}

//MARK: - TextField

final class CustomTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init() {
        super.init(frame: .zero)
        font = Fonts.textFields
        textAlignment = .left
        translatesAutoresizingMaskIntoConstraints = false
        
    }
    
}

//MARK: - Button

final class CustomButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init(title: String, color: UIColor, image: UIImage?, font: UIFont) {
        super.init(frame: .zero)
        if let image = image {
            setImage(image, for: .normal)
        }
        setTitle(title, for: .normal)
        layer.cornerRadius = 25
        tintColor = color
        backgroundColor = .white
        setTitleColor(color, for: .normal)
        titleLabel?.font = font
        layer.borderWidth = 2
        layer.borderColor = color.cgColor
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 50 ).isActive = true
        widthAnchor.constraint(equalToConstant: 170).isActive = true
    }
    
    
}

//MARK: - CustomView

final class CustomView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init() {
        super.init(frame: .zero)
        layer.cornerRadius = 5
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 60).isActive = true
        
    }
}

