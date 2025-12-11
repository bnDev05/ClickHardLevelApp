//
//  ClickHardLevelAppApp.swift
//  ClickHardLevelApp
//
//  Created by Behruz Norov on 11/12/25.
//

import SwiftUI
import CoreData

@main
struct ClickHardLevelAppApp: App {
    let persistenceController = PersistenceController.shared

    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
