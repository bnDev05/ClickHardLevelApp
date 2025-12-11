//
//  ContentView.swift
//  ClickHardLevelApp
//
//  Created by Behruz Norov on 11/12/25.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @StateObject private var viewModel = TodoViewModel()
    @State private var showingAddView = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                FilterBar(viewModel: viewModel)
                    .padding(.bottom, 10)
                
                TodoListView(viewModel: viewModel)
            }
            .navigationTitle("To-Do List")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Menu {
                        Picker("Sort by", selection: $viewModel.sortOption) {
                            Text("Date Created").tag(TodoViewModel.SortOption.dateCreated)
                            Text("Due Date").tag(TodoViewModel.SortOption.dueDate)
                            Text("Priority").tag(TodoViewModel.SortOption.priority)
                            Text("Title").tag(TodoViewModel.SortOption.title)
                        }
                    } label: {
                        Image(systemName: "arrow.up.arrow.down")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddView = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddView) {
                AddTodoView(viewModel: viewModel)
            }
        }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
