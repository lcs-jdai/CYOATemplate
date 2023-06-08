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
    @State var textSize:Int = 20
    @State private var showTextMenu = false
    @State private var showMenu = false
    @State private var buttonSwitch2 = true
    //    @State var tM: textMenu = textMenu(textSize: Int)
    @AppStorage("isDarkMode") private var isDarkMode:Bool = false
    @Environment(\.presentationMode) var presentationMode
    
    @State var nodeHistory: [Int]  = [1] // may be changed into a deque later on
    
    
    // MARK: Computed properties
    var body: some View {
        //        ZStack(alignment: .bottom){
        VStack(spacing: 10) {
            Spacer()
            HStack {
                Text("\(currentNodeId)")
                    .font(.largeTitle)
                    .padding(.top,40)
                    .padding(.horizontal,20)
                
                
                Spacer()
            }
            
            NodeView(currentNodeId: currentNodeId)
                .font(.system(size: CGFloat(textSize)))
                .padding(20)
            
            Divider()
            
            EdgesView(currentNodeId: $currentNodeId, nodeHistories: $nodeHistory)
                .font(.system(size: CGFloat(textSize)))
                .padding(20)
            Spacer()

            Button(action: {playSound()}, label: {Text("Play Background Music")})

            // Menu Bar
            if showMenu {
                PopUpMenu()
                    .padding(.vertical,20)
            }
            
            if showTextMenu{
                TextMenu(textSize: $textSize)
                    .padding(.vertical,20)
            }
            
            HStack{
                Spacer()
                
                tabIcon1(showTextMenu: $showTextMenu, buttonSwitch2: $buttonSwitch2)
                    .onTapGesture {
                        withAnimation{
                            showTextMenu.toggle()
                            buttonSwitch2.toggle()
                        }
                    }
                
                Spacer()
                tabMenuIcon(showMenu: $showMenu, buttonSwitch2: $buttonSwitch2)
                    .onTapGesture {
                        withAnimation{
                            buttonSwitch2.toggle()
                            showMenu.toggle()
                            
                        }
                    }
                
                Spacer()
                tabIcon2(buttonSwitch2: $buttonSwitch2)
                    .onTapGesture {
                        withAnimation{
                            isDarkMode.toggle()
                            buttonSwitch2.toggle()
                            
                        }
                    }
                Spacer()
                
            }
            .frame(height: UIScreen.main.bounds.height / 10)
            .frame(width: UIScreen.main.bounds.width / 1)
            .background(Color(.systemGray5))

            // play background music in swift
        }
        
        //        }
        
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
    @Binding var buttonSwitch2: Bool
    var body: some View{
        Image(systemName: "light.max")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 30,height: 20)
            .foregroundColor(buttonSwitch2 ? .white : .black)
        
    }
}

struct tabIcon1:View{
    @Binding var showTextMenu: Bool
    @Binding var buttonSwitch2: Bool
    var body: some View{
        Image(systemName: "textformat")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 30,height: 20)
            .foregroundColor(buttonSwitch2 ? .white : .black)
        
        
        
        
    }
}

struct tabIcon2:View{
    @Binding var buttonSwitch2: Bool
    
    var body: some View{
        Image(systemName: buttonSwitch2 ? "moon.zzz" : "sun.max")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 30,height: 20)
            .foregroundColor(buttonSwitch2 ? .white : .black)
        
    }
}

struct PopUpMenu: View{
    @State private var brightness: Double = 1.0
    var body: some View{
        HStack{
            Text("Brightness:")
            Slider(value: $brightness, in: 0.0...1.0){
            }
            .onChange(of: brightness){ _ in
                UIScreen.main.brightness = CGFloat(brightness)
                
            }
        }
        .transition(.scale)
        .padding(.horizontal,40)
        
    }
}


struct TextMenu: View{
    @Binding var textSize: Int
    var body: some View{
        HStack{
            Button(action: {
                textSize += 1
            }, label: {
                
                Image(systemName: "plus")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 30,height: 20)
                    .foregroundColor(.blue)
                
            })
            
            Spacer()
            
            Text("\(textSize)")
                .font(.system(size: 20))
            
            Spacer()
            
            Button(action: {
                textSize -= 1
            }, label: {
                Image(systemName: "minus")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 3.5,height: 3.5)
                    .foregroundColor(.blue)
            })
        }
        .transition(.scale)
        .padding(.horizontal,40)
        .padding(.trailing,27)
        
    }
}
