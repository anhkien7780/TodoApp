//
//  AddNewTaskHeaderView.swift
//  TodoApp
//
//  Created by Admin on 6/20/25.
//

import Foundation
import UIKit

class AddNewTaskHeaderView: UIView{
    let closeIconView = CloseIconView()
    let headerTitleView: UILabel = {
        let label = UILabel()
        label.text = "Add New Task"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .white
        return label
    }()
    
    init(){
        super.init(frame: .zero)
        
        setupLayout()
    }
    
    private func setupLayout(){
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor(hex: "#4A3780")
        heightAnchor.constraint(equalToConstant: 96).isActive = true
        translatesAutoresizingMaskIntoConstraints = false
        
        [closeIconView, headerTitleView].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        [closeIconView, headerTitleView].forEach{
            addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            closeIconView.centerYAnchor.constraint(equalTo: centerYAnchor),
            closeIconView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            headerTitleView.centerXAnchor.constraint(equalTo: centerXAnchor),
            headerTitleView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
