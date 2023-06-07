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
    @BlackbirdLiveModels var nodes: Blackbird.LiveResults<Node>
    @BlackbirdLiveModels var edges: Blackbird.LiveResults<Edge>
    private var graph : [[Int]]{
        return make_graph(node_count: nodes.results.count, nodes: nodes, edges:edges)
    }
    
    var body: some View {
        VStack{
            Text("\(edges.results.count)")
            Text("\(nodes.results.count)")
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
    }
    
    func make_graph(node_count: Int, nodes: Blackbird.LiveResults<Node>, edges: Blackbird.LiveResults<Edge>) -> [[Int]]{
        var graph: [[Int]] = []
        for i in 0..<node_count{
            graph.append([])
            for _ in 0..<node_count{
                graph[i].append(0)
            }
        }
        
        
        return graph
    }
    
    init(start_node: Int){
        _nodes = BlackbirdLiveModels({ db in
            try await Node.read(from: db,
                                sqlWhere: "id > 0")
        })
        
        _edges = BlackbirdLiveModels({ db in
            try await Edge.read(from: db,
                                sqlWhere: "id > 0")
        })
        
        
        // creating the graph datastructure
//        let node_count = _nodes.wrappedValue.results.count
//        var graph = make_graph(node_count: node_count + 1 ) // since the node starts at one
//
//        for edge in _edges.wrappedValue.results{
//            let from_node_id = edge.from_node_id
//            let to_node_id = edge.to_node_id
//            graph[from_node_id][to_node_id] = 1 // represents the weight (this really should be something else)!
//            graph[to_node_id][from_node_id] = 1
//        }
//
//        // print out the graph
//        for i in 0..<graph.count{
//            for x in 0..<graph[i].count{
//                if graph[i][x] != 0 {
//                    print("\(i): \(x) weight: \(graph[i][x])") // i, and x is connected and
//                }
//            }
//        }
//
        
        print("screen width: \(screenWidth) screen height: \(screenHeight)")
    }
    
}
