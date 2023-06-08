//
//  Settings.swift
//  CYOATemplate
//
//  Created by Vincent He on 2023-06-08.
//

import Foundation

class Settings: ObservableObject{
    
    init(){
        testing = 10
        
    }
    @Published private var testing: Int
}
