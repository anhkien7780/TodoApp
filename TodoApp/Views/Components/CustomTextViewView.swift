//
//  CustomTextViewView.swift
//  TodoApp
//
//  Created by Admin on 6/20/25.
//

import Foundation

import UIKit

class CustomTextViewView: UIView {
    
    private let label = UILabel()
    let textView = UITextView()
    
    init(labelText: String, placeholder: String? = nil, height: CGFloat = 120) {
        super.init(frame: .zero)
        setupViews()
        setupConstraints(height: height)
        label.text = labelText
        setPlaceholder(placeholder ?? "")
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        setupConstraints(height: 177)
    }
    
    private func setupViews() {
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.textColor = .lightGray
        textView.layer.cornerRadius = 8
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.systemGray4.cgColor
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.delegate = self
    }
    
    private func setupConstraints(height: CGFloat) {
        addSubview(label)
        addSubview(textView)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            textView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 8),
            textView.leadingAnchor.constraint(equalTo: leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: trailingAnchor),
            textView.heightAnchor.constraint(equalToConstant: height),
            textView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    // MARK: Placeholder Logic
    private var placeholderText: String = ""
    
    func setPlaceholder(_ text: String) {
        placeholderText = text
        textView.text = text
        textView.textColor = .lightGray
    }
}

// MARK: - UITextViewDelegate
extension CustomTextViewView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == placeholderText {
            textView.text = ""
            textView.textColor = .black
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = placeholderText
            textView.textColor = .lightGray
        }
    }
}
