//
//  TodoItemView.swift
//  TodoApp
//
//  Created by Admin on 6/20/25.
//

import Foundation
import UIKit

class TodoItemView: UIView {
    private var iconView = RoundedIconView()
    private let titleView = UILabel()
    private let checkboxView = CheckboxButton(isChecked: false)
    private let verticalStack = UIStackView()
    private let containerView = UIView()

    init() {
        super.init(frame: .zero)
    }

    init(item: TodoItemDetail,
         onCheckChange: ((Bool) -> Void)?) {
        super.init(frame: .zero)
        configure(
            title: item.taskTitle,
            category: item.category ?? .Task,
            time: item.time,
            isChecked: item.isCompleted,
            onCheckChange: onCheckChange
        )
    }

    func configure(
        title: String,
        category: Category,
        time: String?,
        isChecked: Bool,
        onCheckChange: ((Bool) -> Void)?
    ) {
        backgroundColor = .white
        containerView.backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        
        var iconBackgroundColor = UIColor()
        var iconImageNamed = ""
        switch category {
        case .Task:
            iconBackgroundColor = UIColor(hex: "#DBECF6")
            iconImageNamed = category.rawValue
        case .Event:
            iconBackgroundColor = UIColor(hex: "#E7E2F3")
            
            iconImageNamed = category.rawValue
        case .Goal:
            iconBackgroundColor = UIColor(hex: "#FEF5D3")
            iconImageNamed = category.rawValue
        case .None:
            iconImageNamed = ""
            iconBackgroundColor = .white
        }


        let image = UIImage(named: iconImageNamed)
        iconView = RoundedIconView(image: image, backgroundColor: iconBackgroundColor)
        iconView.translatesAutoresizingMaskIntoConstraints = false
        
        titleView.text = title
        titleView.font = UIFont.boldSystemFont(ofSize: 16)
        titleView.numberOfLines = 1
        

        checkboxView.isChecked = isChecked
        checkboxView.onCheckChange = onCheckChange
        checkboxView.translatesAutoresizingMaskIntoConstraints = false

        verticalStack.axis = .vertical
        verticalStack.spacing = 1
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        verticalStack.addArrangedSubview(titleView)
        

        if let time = time {
            let timeLabel = UILabel()
            timeLabel.text = time
            timeLabel.font = UIFont.systemFont(ofSize: 12)
            timeLabel.textColor = .gray
            if isChecked{
                timeLabel.attributedText = strikeThrounghTextFormat(text: time)
                timeLabel.alpha = 0.3
            }
            verticalStack.addArrangedSubview(timeLabel)
        }
        
        let blurredContainerView = UIView()
        blurredContainerView.translatesAutoresizingMaskIntoConstraints = false
        blurredContainerView.backgroundColor = .clear
        blurredContainerView.clipsToBounds = true

        if isChecked {
            let blurEffect = UIBlurEffect(style: .light)
            let blurView = UIVisualEffectView(effect: blurEffect)
            blurView.translatesAutoresizingMaskIntoConstraints = false
            blurredContainerView.addSubview(blurView)
            
            NSLayoutConstraint.activate([
                blurView.topAnchor.constraint(equalTo: blurredContainerView.topAnchor),
                blurView.leadingAnchor.constraint(equalTo: blurredContainerView.leadingAnchor),
                blurView.trailingAnchor.constraint(equalTo: blurredContainerView.trailingAnchor),
                blurView.bottomAnchor.constraint(equalTo: blurredContainerView.bottomAnchor)
            ])
            
            titleView.attributedText = strikeThrounghTextFormat(text: title)
            titleView.alpha = 0.3
            iconView.alpha = 0.3
        }

        blurredContainerView.addSubview(verticalStack)

        NSLayoutConstraint.activate([
            verticalStack.topAnchor.constraint(equalTo: blurredContainerView.topAnchor),
            verticalStack.leadingAnchor.constraint(equalTo: blurredContainerView.leadingAnchor),
            verticalStack.trailingAnchor.constraint(equalTo: blurredContainerView.trailingAnchor),
            verticalStack.bottomAnchor.constraint(equalTo: blurredContainerView.bottomAnchor)
        ])
        
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(iconView)
        containerView.addSubview(blurredContainerView)
        containerView.addSubview(checkboxView)

        addSubview(containerView)

        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func strikeThrounghTextFormat(text: String) -> NSAttributedString{
        let attributedText = NSAttributedString(
            string: text,
            attributes: [
                .strikethroughStyle: NSUnderlineStyle.single.rawValue,
                .foregroundColor: UIColor.gray
            ]
        )
        return attributedText
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            // Container padding
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            containerView.heightAnchor.constraint(equalToConstant: 48),

            // Rounded icon view
            iconView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            iconView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 48), // 24 + 12*2 padding
            iconView.heightAnchor.constraint(equalToConstant: 48),

            // Checkbox
            checkboxView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            checkboxView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            checkboxView.widthAnchor.constraint(equalToConstant: 24),
            checkboxView.heightAnchor.constraint(equalToConstant: 24),

            // Vertical stack
            verticalStack.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 12),
            verticalStack.trailingAnchor.constraint(lessThanOrEqualTo: checkboxView.leadingAnchor, constant: -12),
            verticalStack.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            verticalStack.topAnchor.constraint(greaterThanOrEqualTo: containerView.topAnchor, constant: 8),
            verticalStack.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor, constant: -8)
        ])
    }
}
