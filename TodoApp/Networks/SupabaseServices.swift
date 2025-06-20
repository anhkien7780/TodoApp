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
    
    func testSupabaseConnection() {
        Task {
            do {
                let items: [TodoItemDetail] = try await SupabaseServices.shared.supabaseClient
                    .from("todos")
                    .select()
                    .limit(1)
                    .execute()
                    .value
                
                if items.isEmpty {
                    print("🟡 Kết nối được, nhưng không có dữ liệu.")
                } else {
                    print("✅ Kết nối Supabase thành công! Dữ liệu đầu tiên: \(items[0])")
                }
            } catch {
                print("❌ Lỗi khi kết nối Supabase: \(error)")
            }
        }
    }
}
