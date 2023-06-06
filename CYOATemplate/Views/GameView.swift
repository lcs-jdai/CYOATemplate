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
                    Spacer()
                }
                
                NodeView(currentNodeId: currentNodeId)
                Divider()
                
                EdgesView(currentNodeId: $currentNodeId)
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
                    //                Button(action: {}, label: {
                    //                    Image(systemName: "textformat")
                    //                        .resizable()
                    //                        .aspectRatio(contentMode: .fill)
                    //                        .frame(width: 30,height: 20)
                    //                        .foregroundColor(.black)
                    //                })
                    
                    
                    Spacer()
                    tabMenuIcon(showMenu: $showMenu, buttonSwitch2: $buttonSwitch2)
                        .onTapGesture {
                            withAnimation{
                                buttonSwitch2.toggle()
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
            }
            if showMenu {
                PopUpMenu()
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
            .foregroundColor(buttonSwitch2 ? .black : .white)
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
            .foregroundColor(buttonSwitch2 ? .black : .white)
    }
}

struct tabIcon2:View{
    @Binding var buttonSwitch2: Bool
    var body: some View{
        Image(systemName: buttonSwitch2 ? "moon.zzz" : "sun.max")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 30,height: 20)
            .foregroundColor(buttonSwitch2 ? .black : .white)
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
        }
        .transition(.scale)
        .padding(.horizontal,40)

    }
}
