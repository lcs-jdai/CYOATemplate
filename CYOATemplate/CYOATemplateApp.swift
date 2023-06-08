//
//  CYOATemplateApp.swift
//  CYOATemplate
//
//  Created by Russell Gordon on 2023-05-29.
//

import SwiftUI
import AVFoundation

@main
struct CYOATemplateApp: App {
    
    var body: some Scene {
        WindowGroup {
            TabView {
                GameView()
                    .environment(\.blackbirdDatabase, AppDatabase.instance)
                    .tabItem {
                        Label("Order", systemImage: "gamecontroller")
                    }
                
                GraphView(start_node: 1)
                    .environment(\.blackbirdDatabase, AppDatabase.instance)
                    .tabItem {
                        Label("Graph", systemImage: "map")
                    }
                
                SettingsView()
                    .environment(\.blackbirdDatabase, AppDatabase.instance)
                    .tabItem {
                        Label("Settings", systemImage: "gear")
                    }
                
                
            }
            .onAppear{
//                playSound()
            }
        }
    }
    
    
    // play sound
    func playSound(){
        
        let url = Bundle.main.url(forResource: "background_music", withExtension: "wav")
        
        guard let url = url else {
            print("Cannot find file background music!")
            return
        }
        do{
            player = try AVAudioPlayer(contentsOf: url)
            player?.numberOfLoops = -1
            player?.play()
        }catch{
            
        }
        
    }
}
