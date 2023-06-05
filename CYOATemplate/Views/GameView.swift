//
//  GameView.swift
//  CYOATemplate
//
//  Created by Russell Gordon on 2023-05-29.
//

import Blackbird
import SwiftUI

struct GameView: View {
    
    // MARK: Stored properties
    @State var currentNodeId: Int = 1
    
    @AppStorage("isDarkMode") private var isDarkMode:Bool = false
    @Environment(\.presentationMode) var presentationMode
    
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
            
            EdgesView(currentNodeId: $currentNodeId)
            Spacer()
            
            HStack{
                Button(action: {}, label: {
                    Image(systemName: "textformat")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 30,height: 20)
                        .foregroundColor(.black)
                })
                
                
                Spacer()
                Button(action: {}, label: {
                    Image(systemName: "light.max")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 30,height: 20)
                        .foregroundColor(.black)
                })
                Spacer()
                Button(action: {
                    isDarkMode.toggle()
                }, label: {
                    Image(systemName: "moon.zzz")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 30,height: 20)
                        .foregroundColor(.black)
                })
            }
            .frame(height: UIScreen.main.bounds.height / 10)
            .frame(maxWidth: .infinity)
            .background(Color(.systemGray5))
            
        }
        .padding()
        .preferredColorScheme(isDarkMode ? .dark:.light)
    }
        
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
        // Make the database available to all other view through the environment
        .environment(\.blackbirdDatabase, AppDatabase.instance)
    }
}
