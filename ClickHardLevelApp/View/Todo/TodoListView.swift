//
//  TodoListView.swift
//  ClickHardLevelApp
//
//  Created by Behruz Norov on 11/12/25.
//

import SwiftUI

struct TodoListView: View {
    @ObservedObject var viewModel: TodoViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.filteredItems) { item in
                NavigationLink(destination: TodoDetailView(item: item, viewModel: viewModel)) {
                    TodoRowView(item: item, viewModel: viewModel)
                }
            }
            .onDelete(perform: deleteItems)
        }
        .listStyle(.plain)
    }
    
    private func deleteItems(at offsets: IndexSet) {
        for index in offsets {
            let item = viewModel.filteredItems[index]
            viewModel.delete(item)
        }
    }
}

#Preview {
    TodoListView(viewModel: TodoViewModel())
}
