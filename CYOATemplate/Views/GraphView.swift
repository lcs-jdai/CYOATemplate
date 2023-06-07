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

struct GraphView: View {
    @Environment(\.blackbirdDatabase) var db: Blackbird.Database?
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Rectangle()
                .fill(.white)

            VertexView(
                radius: 16,
                color: .black,
                coordinate: CGPoint(x: 50, y: 50))

            EdgeShape(
                start: CGPoint(x: 50, y: 50),
                end: CGPoint(x: 320, y: 50))
            .stroke()
            
            VertexView(
                radius: 16,
                color: .red,
                coordinate: CGPoint(x: 320, y: 50))
        }
    }
    
    init(){
        
    }
    
}
