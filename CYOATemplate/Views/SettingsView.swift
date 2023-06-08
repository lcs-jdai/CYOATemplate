//
//  SettingsView.swift
//  CYOATemplate
//
//  Created by Vincent He on 2023-06-08.
//

import SwiftUI
import AVFoundation

struct SettingsView: View {
    @State var textSize:Int = 15
    @State private var showTextMenu = false
    @State private var showMenu = false
    @State private var buttonSwitch2 = true
    @AppStorage("isDarkMode") private var isDarkMode:Bool = true
    
    @State private var isMusicOn: Bool = true
    @State private var musicTogglePlacehoder: Bool = true
    @State private var musicVolume: Float = 1.0
    
    // Control the audio level
    private var player: AVAudioPlayer
    init(player: AVAudioPlayer){
        self.player = player
    }
    
    var body: some View {
        VStack{
            // The Actual Menu
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
            
            // Pop up Menus
            if showMenu{
                PopUpMenu()
            }
            
            if showTextMenu{
                TextMenu(textSize: $textSize)
                    .padding(.bottom,20)
            }

            List{
                Section(header: Text("Music")){
                    // turning on and off music
                    Toggle("On / Off", isOn: $musicTogglePlacehoder)
                        .onChange(of: musicTogglePlacehoder){ value in
                            stopMusic()
                        }
                    // control the volume
                    HStack{
                        Text("Volume")
                        Spacer()
                        Slider(value: $musicVolume)
                            .onChange(of: musicVolume){volume in
                                changeMusicVolume()
                            }
                    }
                    
                }
            }
            
            
            Spacer()
        }
    }
    
    func changeMusicVolume(){
        player.volume = musicVolume
    }
    
    func stopMusic() {
        if isMusicOn{
            player.stop()
            isMusicOn = false
            return
        }
        
        player.numberOfLoops = -1
        player.play()
        isMusicOn = true
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

