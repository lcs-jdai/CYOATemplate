//
//  GameView.swift
//  CYOATemplate
//
//  Created by Russell Gordon on 2023-05-29.
//

import Blackbird
import SwiftUI
import AVFoundation

struct GameView: View {
    
    // MARK: Stored properties
    @State var currentNodeId: Int = 1
    @State var nodeHistory: [Int]  = [1] // may be changed into a deque later on
    
    // MARK: Computed properties
    var body: some View {
        VStack(spacing: 10) {
            
            HStack {
                Text("\(currentNodeId)")
                    .font(.largeTitle)
                Spacer()
            }
            
            NodeView(currentNodeId: currentNodeId)
            
            Divider()
            
            EdgesView(currentNodeId: $currentNodeId, nodeHistories: $nodeHistory)
                        
            Spacer()
            
            // play background music in swift
            Button(action: {playSound()}, label: {Text("Play Background Music")})
            
        }
        .padding()
    }
    
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

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
        // Make the database available to all other view through the environment
        .environment(\.blackbirdDatabase, AppDatabase.instance)
    }
}
