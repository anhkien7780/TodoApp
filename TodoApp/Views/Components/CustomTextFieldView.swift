//
//  CustomTextFieldView.swift
//  TodoApp
//
//  Created by Admin on 6/20/25.
//

import Foundation
import UIKit

class CustomTextFieldView: UIView {
    
    private let label = UILabel()
    let textField = UITextField()
    let suffixButton = UIButton()
    private let suffixIconView = UIImageView()
    
    init(labelText: String, placeholder: String, suffixIcon: UIImage? = nil, textFieldHeight: CGFloat? = nil) {
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
        
        label.text = labelText
        textField.placeholder = placeholder
        if let icon = suffixIcon {
            setSuffixIconButton(icon)
        }
        if let heightConstant = textFieldHeight {
            setTextFieldHeight(height: heightConstant)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        suffixButton.translatesAutoresizingMaskIntoConstraints = false
        
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.rightViewMode = .always
        
        suffixIconView.contentMode = .scaleAspectFit
        suffixIconView.tintColor = .gray
        suffixIconView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
    }
    
    private func setupConstraints() {
        addSubview(label)
        addSubview(textField)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            textField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 8),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setSuffixIconButton(_ image: UIImage) {
        var config = UIButton.Configuration.filled()
        config.image = image
        config.baseBackgroundColor = .clear
        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 16)
        suffixButton.configuration = config
        suffixIconView.contentMode = .scaleAspectFit
        suffixButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        textField.rightView = suffixButton
        textField.rightViewMode = .always
    }

    
    func setTextFieldHeight(height: CGFloat){
        textField.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
}

