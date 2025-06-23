//
//  ToDoListViewModel.swift
//  TodoApp
//
//  Created by Admin on 6/20/25.
//

import Foundation

class ToDoListViewModel{
    private(set) var uncompletedItems: [TodoItemDetail] = []
    private(set) var completedItems: [TodoItemDetail] = []
    
    var onDataChanged: (() -> Void)?
    
    init() {
        SupabaseServices.shared.loadSupabaseTodoData(
            completion: { [weak self] data in
                DispatchQueue.main.async {
                    self?.uncompletedItems = data.filter{ !$0.isCompleted }
                    self?.completedItems = data.filter{ $0.isCompleted }
                    self?.onDataChanged?()
                }
            }
        )
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
    
    func addNewTodoItemDetail(item: TodoItemDetail){
        SupabaseServices.shared.addSupabaseTodoITem(item: item, completion: { insertedData, isSuccess in
            DispatchQueue.main.async {
                if isSuccess {
                    self.addNewUncompletedItem(insertedData[0])
                }
            }
        })
    }
    
    func unCompletedItemList() -> [TodoItemDetail] {
        return uncompletedItems
    }
    
    func completedItemList() -> [TodoItemDetail] {
        return completedItems
    }
    
    private func addNewUncompletedItem(_ item: TodoItemDetail) {
        guard !item.isCompleted else { return }
        uncompletedItems.append(item)
        onDataChanged?()
    }
}
