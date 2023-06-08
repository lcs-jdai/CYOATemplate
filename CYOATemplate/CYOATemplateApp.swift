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
            NavigationView{
                VStack{
                    NavigationLink(destination: {GraphView(start_node: 1)
                            .environment(\.blackbirdDatabase, AppDatabase.instance)
                    }, label: {Text("Graph View")})
                    
                    NavigationLink(destination: {GameView()
                            .environment(\.blackbirdDatabase, AppDatabase.instance)
                    }, label: {Text("Game View")})
                }
            }
        }
    }
}
