//
//  GameView.swift
//  CYOATemplate
//
//  Created by Russell Gordon on 2023-05-29.
//

import Blackbird
import SwiftUI
import UIKit
import Combine
import AVFoundation

struct GameView: View {
    
    // MARK: Stored properties
    @State var currentNodeId: Int = 1
    @State var nodeHistory: [Int]  = [1]
    // need to store the following
    @AppStorage("isDarkMode") private var isDarkMode:Bool = true
    @Binding var textSize:Int
    
    init(textSize: Binding<Int>){
        _textSize = textSize
    }
    
    // MARK: Computed properties
    var body: some View {
        VStack(spacing: 10) {
            Spacer()
            HStack {
                Text("\(currentNodeId)")
                    .font(.custom("Freshman", size: CGFloat(textSize)))
                    .font(.largeTitle)
                    .padding(.top,40)
                    .padding(.horizontal,20)
                
                
                Spacer()
            }
            
            NodeView(currentNodeId: currentNodeId)
                .font(.custom("Freshman", size: CGFloat(textSize)))
//                .font(.system(size: CGFloat(textSize)))
                .padding(20)
            
            
            
            Divider()
            
            EdgesView(currentNodeId: $currentNodeId, nodeHistories: $nodeHistory)
                .font(.custom("Freshman", size: CGFloat(textSize)))
//                .font(.system(size: CGFloat(textSize)))
                .padding(20)
            Spacer()
            
            
            
            Spacer()
        }
        
        .padding()
        .ignoresSafeArea()
        .preferredColorScheme(isDarkMode ? .dark:.light)
        
    }
    
}



struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(textSize: .constant(15))
        // Make the database available to all other view through the environment
            .environment(\.blackbirdDatabase, AppDatabase.instance)
    }
}
