//
//  FilterBar.swift
//  ClickHardLevelApp
//
//  Created by Behruz Norov on 11/12/25.
//

import SwiftUI

struct FilterBar: View {
    @ObservedObject var viewModel: TodoViewModel
    
    var body: some View {
        HStack {
            FilterButton(title: "All", isSelected: viewModel.filterOption == .all) {
                viewModel.filterOption = .all
            }
            FilterButton(title: "Active", isSelected: viewModel.filterOption == .active) {
                viewModel.filterOption = .active
            }
            FilterButton(title: "Completed", isSelected: viewModel.filterOption == .completed) {
                viewModel.filterOption = .completed
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(
            Color(.systemGray6)
                .clipShape(Capsule())
        )
    }
}

#Preview {
    FilterBar(viewModel: TodoViewModel())
}
