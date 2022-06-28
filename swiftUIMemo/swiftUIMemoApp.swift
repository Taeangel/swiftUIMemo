//
//  swiftUIMemoApp.swift
//  swiftUIMemo
//
//  Created by song on 2022/06/29.
//

import SwiftUI

@main
struct swiftUIMemoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
          MemoListScene()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
