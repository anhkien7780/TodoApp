//
//  CategoryButtonView.swift
//  TodoApp
//
//  Created by Admin on 6/20/25.
//

import Foundation
import UIKit

class CategoryButtonView: UIButton {
    
    private let iconView: RoundedIconView
    var category: Category

    init(category: Category) {
        self.category = category
        let image = UIImage(named: category.rawValue)
        self.iconView = RoundedIconView(image: image)

        super.init(frame: .zero)
        setupView()
        addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.isUserInteractionEnabled = false
        addSubview(iconView)

        // Bo tròn nút nếu cần, hoặc để hình chữ nhật
        layer.cornerRadius = 25
        backgroundColor = .white
        
        clipsToBounds = true
        switch category {
        case .Task:
            iconView.setBackgroundColor(UIColor(hex: "#DBECF6"))
        case .Event:
            iconView.setBackgroundColor(UIColor(hex: "#E7E2F3"))
        case .Goal:
            iconView.setBackgroundColor(UIColor(hex: "#FEF5D3"))
        case .None:
            iconView.backgroundColor = .clear
        }
        NSLayoutConstraint.activate([
            iconView.centerXAnchor.constraint(equalTo: centerXAnchor),
            iconView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 48),
            iconView.heightAnchor.constraint(equalToConstant: 48),
            self.widthAnchor.constraint(equalToConstant: 50),
            self.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    @objc private func didTapButton() {
        isSelected.toggle()
        updateVisualState()
    }

    private func updateVisualState() {
        if isSelected {
            iconView.setBackgroundColor(.gray)
        } else {
            switch category {
            case .Task:
                iconView.setBackgroundColor(UIColor(hex: "#DBECF6"))
            case .Event:
                iconView.setBackgroundColor(UIColor(hex: "#E7E2F3"))
            case .Goal:
                iconView.setBackgroundColor(UIColor(hex: "#FEF5D3"))
            case .None:
                iconView.backgroundColor = .clear
            }
        }
    }

    override var isSelected: Bool {
        didSet {
            updateVisualState()
        }
    }
}
