//
//  GraphView.swift
//  CYOATemplate
//
//  Created by Vincent He on 2023-06-06.
//

import SwiftUI
import Blackbird
import Foundation

struct EdgeShape: Shape {
    var start: CGPoint
    var end: CGPoint
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: start)
        path.addLine(to: end)
        
        return path
    }
}

struct VertexView: View {
    var radius: Double
    var color: Color
    var coordinate: CGPoint
    
    var body: some View {
        Circle()
            .fill(color)
            .frame(width: radius * 2, height: radius * 2, alignment: .center)
            .offset(x: coordinate.x - radius, y: coordinate.y - radius)
    }
}

let screenSize: CGRect = UIScreen.main.bounds
let screenWidth = screenSize.width - 40
let screenHeight = screenSize.height - 40

struct GraphView: View {
    @Environment(\.blackbirdDatabase) var db: Blackbird.Database?
    
    // storing all of the edges
    @BlackbirdLiveModels var edges: Blackbird.LiveResults<Edge>
    @BlackbirdLiveModels var nodes: Blackbird.LiveResults<Node>
    
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Rectangle()
                .fill(.white)

            VertexView(
                radius: 16,
                color: .black,
                coordinate: CGPoint(x: screenWidth, y: screenHeight))

            EdgeShape(
                start: CGPoint(x: screenWidth, y: screenHeight),
                end: CGPoint(x: 0, y: 0))
            .stroke()
            
            VertexView(
                radius: 16,
                color: .red,
                coordinate: CGPoint(x: 0, y: 0))
        }
    }
    
    init(){
        _nodes = BlackbirdLiveModels({ db in
            try await Node.read(from: db)
        })
        
        _edges = BlackbirdLiveModels({ db in
            try await Edge.read(from: db)
        })
        
        print("screen width: \(screenWidth) screen height: \(screenHeight)")
    }
    
}
