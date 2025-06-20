//
//  ToDoListViewModel.swift
//  TodoApp
//
//  Created by Admin on 6/20/25.
//

import Foundation

class ToDoListViewModel{
    private(set) var uncompletedItems: [TodoItemDetail]
    private(set) var completedItems: [TodoItemDetail]
    
    var onDataChanged: (() -> Void)?
    
    init(items: [TodoItemDetail]) {
        self.uncompletedItems = items.filter{ !$0.isCompleted }
        self.completedItems = items.filter{ $0.isCompleted }
    }
    
    func toggleCompletion(for item: TodoItemDetail){
        if item.isCompleted{
            completedItems.removeAll { $0.id == item.id }
            var updated = item
            updated.isCompleted = false
            uncompletedItems.append(updated)
        } else {
            uncompletedItems.removeAll{ $0.id == item.id }
            var updated = item
            updated.isCompleted = true
            completedItems.append(updated)
        }
        
        onDataChanged?()
    }
    
    func unCompletedItemList() -> [TodoItemDetail] {
        return uncompletedItems
    }
    
    func completedItemList() -> [TodoItemDetail] {
        return completedItems
    }
    
    func addNewUncompletedItem(_ item: TodoItemDetail) {
        guard !item.isCompleted else { return }
        uncompletedItems.append(item)
        onDataChanged?()
    }
}
