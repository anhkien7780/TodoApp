//
//  AppCoordinator.swift
//  TodoApp
//
//  Created by Admin on 6/20/25.


import Foundation
import UIKit

class AppCoordinator: Coordinator {
    var window: UIWindow?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var todoListViewModel = ToDoListViewModel(items: [])
    
    init(window: UIWindow?) {
        self.navigationController = UINavigationController()
        self.window = window
    }
    
    func start() {
        showToDoList()
    }
    
    func showToDoList(){
        let todoListVC = ToDoListViewController(viewModel: todoListViewModel)
        todoListVC.coordinator = self
        navigationController.viewControllers = [todoListVC]
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    func navigateToAddNewTask() {
        let addNewTaskVC = AddNewTaskViewController(viewModel: todoListViewModel)
        addNewTaskVC.modalPresentationStyle = .pageSheet // hoặc .formSheet, .automatic, .overCurrentContext
        addNewTaskVC.modalTransitionStyle = .coverVertical // từ dưới lên
        navigationController.present(addNewTaskVC, animated: true, completion: nil)
    }
    
}
