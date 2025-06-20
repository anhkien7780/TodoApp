//
//  ListTodoHeaderView.swift
//  TodoApp
//
//  Created by Admin on 6/20/25.
//

import Foundation
import UIKit

class ListTodoHeaderView: UIView {
    let topNav: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let headerTitle: UILabel = {
        let label = UILabel()
        label.text = "My Todo List"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = .white
        return label
    }()
    
    
    init(dateString: String){
        super.init(frame: .zero)
        topNav.text = dateString
        backgroundColor = UIColor(hex: "#4A3780")
        
        addSubview(topNav)
        addSubview(headerTitle)
        
        setupAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupAutoLayout(){
        topNav.translatesAutoresizingMaskIntoConstraints = false
        headerTitle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topNav.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            topNav.centerXAnchor.constraint(equalTo: centerXAnchor),
            headerTitle.topAnchor.constraint(equalTo: topNav.bottomAnchor, constant: 42),
            headerTitle.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
