//
//  ToDoListViewController.swift
//  TodoApp
//
//  Created by Admin on 6/20/25.
//

import Foundation
import UIKit

class ToDoListViewController: UIViewController {
    weak var coordinator: AppCoordinator?
    private var viewModel: ToDoListViewModel
    let formatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd yyyy"
        dateFormatter.locale = Locale(identifier: "en_US")
        return dateFormatter
    }()
    private let uncompletedItemStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.backgroundColor = UIColor(hex: "E5E9ED")
        stack.spacing = 1
        stack.layer.cornerRadius = 16
        stack.clipsToBounds = true
        return stack
    }()
    private var completedHeader: UILabel = {
        let label = UILabel()
        label.text = "Completed"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    private let completedItemStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.backgroundColor = UIColor(hex: "E5E9ED")
        stack.spacing = 1
        stack.layer.cornerRadius = 16
        stack.clipsToBounds = true
        return stack
    }()
    private let addNewTodoItemButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add New Task", for: .normal)
        button.backgroundColor = UIColor(hex: "#4A3780")
        button.layer.cornerRadius = 28
        button.heightAnchor.constraint(equalToConstant: 56).isActive = true
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        return button
    }()
    private let scrollableList = UIScrollView()
    private let headerView : ListTodoHeaderView = {
        let formatter: DateFormatter = {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM dd yyyy"
            dateFormatter.locale = Locale(identifier: "en_US")
            return dateFormatter
        }()
        let dateString = formatter.string(from: Date())
        let view = ListTodoHeaderView(dateString: dateString)
        return view
    }()
    
    init(viewModel: ToDoListViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.onDataChanged = {
            [weak self] in
            self?.reloadUI()
        }
    }
    
    private func reloadUI() {
        uncompletedItemStack.arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }
        
        completedItemStack.arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }
        let uncompletedItems = viewModel.uncompletedItems
        if uncompletedItems.isEmpty {
            let spacer = UIView()
            spacer.backgroundColor = UIColor(hex: "#4A3780")
            spacer.heightAnchor.constraint(equalToConstant: 56).isActive = true
            uncompletedItemStack.addArrangedSubview(spacer)
        } else {
            for item in viewModel.unCompletedItemList() {
                let todoItemView = TodoItemView(item: item){
                    [weak self] isCompleted in
                    self?.viewModel.toggleCompletion(for: item)
                }
                uncompletedItemStack.addArrangedSubview(todoItemView)
            }
        }
        for item in viewModel.completedItemList() {
            let todoItemView = TodoItemView(item: item){
                [weak self] isUncompleted in
                self?.viewModel.toggleCompletion(for: item)
            }
            completedItemStack.addArrangedSubview(todoItemView)
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadUI()
        view.backgroundColor = UIColor(hex: "#F1F5F9")
        
        
        
        addNewTodoItemButton.addTarget(self, action: #selector(didTapAdd), for: .touchUpInside)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollableList.delegate = self
        scrollableList.translatesAutoresizingMaskIntoConstraints = false
        scrollableList.contentInset = UIEdgeInsets(top: 1, left: 0, bottom: 100, right: 0)
        
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollableList.addSubview(contentView)
        contentView.addSubview(headerView)
        
        
        [uncompletedItemStack, completedHeader, completedItemStack].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
                
        view.addSubview(scrollableList)
        view.addSubview(addNewTodoItemButton)
        scrollableList.translatesAutoresizingMaskIntoConstraints = false
        addNewTodoItemButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            //Scrollable View
            scrollableList.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollableList.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollableList.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollableList.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            // Content View
            contentView.topAnchor.constraint(equalTo: scrollableList.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollableList.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollableList.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollableList.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollableList.frameLayoutGuide.widthAnchor),
            
            
            headerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 222),
            
            uncompletedItemStack.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -60),
            uncompletedItemStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            uncompletedItemStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            completedHeader.topAnchor.constraint(equalTo: uncompletedItemStack.bottomAnchor, constant: 24),
            completedHeader.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            completedHeader.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            completedItemStack.topAnchor.constraint(equalTo: completedHeader.bottomAnchor, constant: 24),
            completedItemStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            completedItemStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            completedItemStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            addNewTodoItemButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            addNewTodoItemButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            addNewTodoItemButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
        ])
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @objc private func didTapAdd(){
        coordinator?.navigateToAddNewTask()
    }
}
