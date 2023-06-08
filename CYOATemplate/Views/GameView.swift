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

    @State private var showTextMenu = false
    @State private var showMenu = false
    @State private var buttonSwitch2 = false
    @AppStorage("isDarkMode") private var isDarkMode:Bool = false
    @Environment(\.presentationMode) var presentationMode

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
            

            EdgesView(currentNodeId: $currentNodeId)
            Spacer()
            
            HStack{
                Spacer()
                
                tabIcon1(showTextMenu: $showTextMenu)
                    .onTapGesture {
                        withAnimation{
                            showTextMenu.toggle()
                        }
                    }
//                Button(action: {}, label: {
//                    Image(systemName: "textformat")
//                        .resizable()
//                        .aspectRatio(contentMode: .fill)
//                        .frame(width: 30,height: 20)
//                        .foregroundColor(.black)
//                })
                
                
                Spacer()
                tabMenuIcon(showMenu: $showMenu)
                    .onTapGesture {
                        withAnimation{
                            showMenu.toggle()
                        }
                    }
//                Button(action: {}, label: {
//                    Image(systemName: "light.max")
//                        .resizable()
//                        .aspectRatio(contentMode: .fill)
//                        .frame(width: 30,height: 20)
//                        .foregroundColor(.black)
//                })
                Spacer()
                tabIcon2(buttonSwitch2: $buttonSwitch2)
                    .onTapGesture {
                        withAnimation{
                            isDarkMode.toggle()
                            buttonSwitch2.toggle()
                        }
                    }
                Spacer()
//                Button(action: {
//                    isDarkMode.toggle()
//                }, label: {
//                    Image(systemName: "moon.zzz")
//                        .resizable()
//                        .aspectRatio(contentMode: .fill)
//                        .frame(width: 30,height: 20)
//                        .foregroundColor(.black)
//                })
            }
            .frame(height: UIScreen.main.bounds.height / 10)
            .frame(width: UIScreen.main.bounds.width / 1)
            .background(Color(.systemGray5))

            EdgesView(currentNodeId: $currentNodeId, nodeHistories: $nodeHistory)
                        
            Spacer()
            
            // play background music in swift
            Button(action: {playSound()}, label: {Text("Play Background Music")})

            
        }
        .padding()
        .ignoresSafeArea()
        .preferredColorScheme(isDarkMode ? .dark:.light)
        
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

struct tabMenuIcon:View{
    @Binding var showMenu: Bool
    var body: some View{
        Image(systemName: "light.max")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 30,height: 20)
            .foregroundColor(.black)
    }
}

struct tabIcon1:View{
    @Binding var showTextMenu: Bool
    var body: some View{
        Image(systemName: "textformat")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 30,height: 20)
            .foregroundColor(.black)
    }
}

struct tabIcon2:View{
    @Binding var buttonSwitch2: Bool
    var body: some View{
        Image(systemName: buttonSwitch2 ? "sun.max":"moon.zzz")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 30,height: 20)
            .foregroundColor(buttonSwitch2 ? .black : .white)
    }
}
