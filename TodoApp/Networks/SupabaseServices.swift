//
//  SupabaseServices.swift
//  TodoApp
//
//  Created by Admin on 6/20/25.
//

import Foundation
import Supabase

class SupabaseServices{
    static let shared = SupabaseServices()
    
    let supabaseClient: SupabaseClient
    
    private init(){
        supabaseClient = SupabaseServices.create()
    }
    
    static func create() -> SupabaseClient{
        let supabaseURL = URL(string: "https://ijywzybzbkkqtlqrwkiu.supabase.co")!
        let supabaseKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImlqeXd6eWJ6YmtrcXRscXJ3a2l1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTAzODg4OTksImV4cCI6MjA2NTk2NDg5OX0.cyp4lp-vhe_D-dSmSfhwS0rZ83SI3XodKLKvetQMIOY"
        let supabaseClient = SupabaseClient(
            supabaseURL: supabaseURL,
            supabaseKey: supabaseKey
        )
        return supabaseClient
    }
    
    func loadSupabaseTodoData(completion: @escaping ([TodoItemDetail]) -> Void){
        Task {
            do {
                let items: [TodoItemDetail] = try await SupabaseServices.shared.supabaseClient
                    .from("todos")
                    .select()
                    .execute()
                    .value
                completion(items)
            } catch {
                print("Supabase connection failed!!!")
            }
        }
    }
    
    func addSupabaseTodoITem(item: TodoItemDetail, completion: @escaping ([TodoItemDetail], Bool) -> Void){
        Task {
            do {
                let inserted: [TodoItemDetail] = try await SupabaseServices.shared.supabaseClient
                    .from("todos")
                    .insert(item)
                    .select()
                    .execute()
                    .value
                completion(inserted, true)
            } catch {
                print("Insert failed")
                completion([], false)
            }
        }
    }
    
    func toggleTodoItemCompletion(item: TodoItemDetail, completion: @escaping ([TodoItemDetail]) -> Void){
        Task {
            do {
                let updated: [TodoItemDetail] = try await
                SupabaseServices.shared.supabaseClient
                    .from("todos")
                    .update(["is_completed": !item.isCompleted])
                    .eq("id", value: item.id)
                    .select()
                    .execute()
                    .value
                completion(updated)
            } catch {
                print("Toggle is completed check box failed")
            }
        }
    }
}
