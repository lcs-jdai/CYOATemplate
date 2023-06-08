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
                    }, label: {
                        Text("Graph View")
                            .font(.system(size: 20, weight: .semibold, design: .rounded))
                            .frame(width:200, height: 60)
                            .background(Color.white)
                            .shadow(color: Color.gray, radius: 20,x: 20,y: 20)
                            .shadow(color: Color.white, radius: 20,x: -20,y: -20)

                    })
                    NavigationLink(destination: {GameView()
                            .environment(\.blackbirdDatabase, AppDatabase.instance)
                    }, label: {
                        Text("Game View")
                            .font(.system(size: 20, weight: .semibold, design: .rounded))
                            .frame(width:200, height: 60)
                            .background(Color.white)
                            .shadow(color: Color.gray, radius: 20,x: 20,y: 20)
                            .shadow(color: Color.white, radius: 20,x: -20,y: -20)
                    })
                }
            }
        }
    }
}
