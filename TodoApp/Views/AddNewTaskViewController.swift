//
//  AddNewTaskViewController.swift
//  TodoApp
//
//  Created by Admin on 6/20/25.
//

import Foundation
import UIKit

class AddNewTaskViewController: UIViewController{
    let viewModel: ToDoListViewModel
    private var selectedCategory: Category?
    
    init(viewModel: ToDoListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let headerView = AddNewTaskHeaderView()
    let bodyStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 24
        
        return stack
    }()
    let taskTextFiledView = CustomTextFieldView(
        labelText: "Task Title",
        placeholder: "Task Title",
        textFieldHeight: 56
    )
    let categoryRowView = UIView()
    let categoryLabelView: UILabel = {
        let label = UILabel()
        label.text = "Category"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    let categoryButtonStackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 16
        stack.axis = .horizontal
        return stack
    }()
    let taskButton = CategoryButtonView(category: .Task)
    let evenButton = CategoryButtonView(category: .Event)
    let goalButton = CategoryButtonView(category: .Goal)
    let dateTimeStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 8
        return stack
    }()
    let dateTextFieldView = CustomTextFieldView(labelText: "Date", placeholder: "Date", suffixIcon: UIImage(named: "calendar"))
    let timeTextFieldView = CustomTextFieldView(labelText: "Time", placeholder: "Time", suffixIcon: UIImage(named: "clock"))
    let noteTextView = CustomTextViewView(labelText: "Notes", placeholder: "Notes")
    let saveButtonView: UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.heightAnchor.constraint(equalToConstant: 56).isActive = true
        button.backgroundColor = UIColor(hex: "#4A3780")
        button.layer.cornerRadius = 28
        button.clipsToBounds = true
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "#F1F5F9")
        setTranslatesAutoresizingMaskIntoConstraints()
        
        [taskButton, evenButton, goalButton].forEach{
            categoryButtonStackView.addArrangedSubview($0)
        }
        [categoryLabelView, categoryButtonStackView].forEach{
            categoryRowView.addSubview($0)
        }
        [dateTextFieldView, timeTextFieldView].forEach{
            $0.setTextFieldHeight(height: 55)
            dateTimeStackView.addArrangedSubview($0)
        }
        [taskTextFiledView, categoryRowView, dateTimeStackView, noteTextView].forEach{
            bodyStackView.addArrangedSubview($0)
        }
        
        
        taskButton.addTarget(self, action: #selector(handleCategorySelection(_:)), for: .touchUpInside)
        evenButton.addTarget(self, action: #selector(handleCategorySelection(_:)), for: .touchUpInside)
        goalButton.addTarget(self, action: #selector(handleCategorySelection(_:)), for: .touchUpInside)
        headerView.closeIconView.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        saveButtonView.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        
        view.addSubview(headerView)
        view.addSubview(bodyStackView)
        view.addSubview(saveButtonView)
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            categoryLabelView.leadingAnchor.constraint(equalTo: categoryRowView.leadingAnchor),
            categoryLabelView.centerYAnchor.constraint(equalTo: categoryRowView.centerYAnchor),
            
            categoryButtonStackView.leadingAnchor.constraint(equalTo: categoryLabelView.trailingAnchor, constant: 24),
            categoryButtonStackView.centerYAnchor.constraint(equalTo: categoryRowView.centerYAnchor),
            categoryButtonStackView.trailingAnchor.constraint(lessThanOrEqualTo: categoryRowView.trailingAnchor),
            
            categoryRowView.heightAnchor.constraint(equalToConstant: 56),
            
            bodyStackView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 24),
            bodyStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            bodyStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            saveButtonView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            saveButtonView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            saveButtonView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
            
        ])
        
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    private func setTranslatesAutoresizingMaskIntoConstraints(){
        [headerView,
         bodyStackView,
         taskTextFiledView,
         categoryRowView,
         categoryLabelView,
         categoryButtonStackView,
         taskButton,
         evenButton,
         goalButton,
         dateTimeStackView,
         dateTextFieldView,
         timeTextFieldView,
         noteTextView,
         saveButtonView,
        ].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    @objc private func handleCategorySelection(_ sender: CategoryButtonView) {
        [taskButton, evenButton, goalButton].forEach { $0.isSelected = false }

        sender.isSelected = true
        selectedCategory = sender.category
    }
    @objc func closeTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func saveTapped(){
        let newItem = TodoItemDetail(
            taskTitle: taskTextFiledView.textField.text ?? "",
            category: selectedCategory,
            date: dateTextFieldView.textField.text,
            time: timeTextFieldView.textField.text,
            isCompleted: false,
            note: noteTextView.textView.text
        )
        if(isValidInput(taskTextFiledView.textField.text)){
            saveTask(newItem: newItem)
        }
    }
    
    func saveTask(newItem: TodoItemDetail) {
        viewModel.addNewTodoItemDetail(item: newItem)
        dismiss(animated: true)
    }
    func isValidInput(_ text: String?) -> Bool {
            guard let text = text else { return false }
            return !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        }
}
