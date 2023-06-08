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
    private var player: AVAudioPlayer
    
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
                
                SettingsView(player: self.player)
                    .environment(\.blackbirdDatabase, AppDatabase.instance)
                    .tabItem {
                        Label("Settings", systemImage: "gear")
                    }
                
                
            }
            .onAppear{
                playSound()
            }
        }
    }
    
    init(){
        
        let url = Bundle.main.url(forResource: "background_music", withExtension: "wav")!
        do{
            player = try AVAudioPlayer(contentsOf: url)
        }catch{
            exit(-1)
        }
    }
    
    // play sound
    func playSound(){
        player.numberOfLoops = -1
        player.play()
    }
}
