//
//  CYOATemplateApp.swift
//  CYOATemplate
//
//  Created by Russell Gordon on 2023-05-29.
//

import SwiftUI

@main
struct CYOATemplateApp: App {
    var body: some Scene {
        WindowGroup {
            GraphView(start_node: 1)
                .environment(\.blackbirdDatabase, AppDatabase.instance)
//            GameView()
//                // Make the database available to all other view through the environment
//                .environment(\.blackbirdDatabase, AppDatabase.instance)

        }
    }
}
