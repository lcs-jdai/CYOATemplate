//
//  GameView.swift
//  CYOATemplate
//
//  Created by Russell Gordon on 2023-05-29.
//

import Blackbird
import SwiftUI
import UIKit

struct GameView: View {
    
    // MARK: Stored properties
    @State var currentNodeId: Int = 1
    @State var textSize:Int = 20
    @State private var showTextMenu = false
    @State private var showMenu = false
    @State private var buttonSwitch2 = true
    @AppStorage("isDarkMode") private var isDarkMode:Bool = false
    @Environment(\.presentationMode) var presentationMode
    
    // MARK: Computed properties
    var body: some View {
        ZStack(alignment: .bottom){
            VStack(spacing: 10) {
                
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
                
                EdgesView(currentNodeId: $currentNodeId)
                    .font(.system(size: CGFloat(textSize)))
                    .padding(20)
                Spacer()
                
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
            }
            if showMenu {
                PopUpMenu()
                .padding(.bottom, 120)
            }
            if showTextMenu{
                textMenu(textSize:20)
                    .padding(.bottom, 120)
            }
        }
        .padding()
        .ignoresSafeArea()
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
//                UIScreen.main.brightness = CGFloat(brightness)
            }
            .onChange(of: brightness){ _ in
                UIScreen.main.brightness = CGFloat(brightness)
                
            }
        }
        .transition(.scale)
        .padding(.horizontal,40)

    }
}


struct textMenu: View{
    @State var textSize: Int
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
