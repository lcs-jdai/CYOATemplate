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
let screenWidth = screenSize.width
let screenHeight = screenSize.height


struct GraphViewRepresentationNode{
    let currentNode: Int
    let previousNode: Int // for backtracking and drawing line
}

struct CircleData{
    let x: Int
    let y: Int
    let node_id: Int
}

struct GraphView: View {
    @BlackbirdLiveModels var nodes: Blackbird.LiveResults<Node>
    @BlackbirdLiveModels var edges: Blackbird.LiveResults<Edge>
    let startNode: Int
    
    private var graph : [[Int]]{
        return make_graph(node_count: nodes.results.count, nodes: nodes, edges:edges)
    }
    
    private var weights: [Int]{
        var weights: [Int] = [] // this represents the weight of the nodes
        // allocate space for weights - change this to a member function
        for _ in 0...nodes.results.count{
            weights.append(1)
        }
        weights.reserveCapacity(nodes.results.count + 1)
        
        for node in nodes.results{
            let id = node.node_id
            var visit_count = node.visit_count
            
            if visit_count == 0{
                visit_count = 1
            }
            
            weights[id] = visit_count
        }
        
        return weights
    }
    
    private var graphRepresentation : [[GraphViewRepresentationNode]] {
        return makeGraphRepresentation()
    }
    
    private var circleLocations: [CircleData]{
        return make_draw_node()
    }
    
    @State private var edgeLocation: [(Int, Int, Int, Int)] = []
    
    var body: some View {
        VStack{
//            Text("\(edges.results.count)")
//            Text("\(nodes.results.count)")
//            Text("\(graph.count)")
//            Text("\(graphRepresentation.count)")
            Button(action: {update_edge_location()}, label: {Text("Draw Edges")})

            ZStack(alignment: .topLeading) {
                Rectangle()
                    .fill(.white)
                
                // rendering all the edges
                ForEach(0..<edgeLocation.count, id: \.self){ num in
                    EdgeShape(start: CGPoint(x: edgeLocation[num].0, y: edgeLocation[num].1),
                              end: CGPoint(x: edgeLocation[num].2, y: edgeLocation[num].3))
                    .stroke(.black, lineWidth: 2)
                }
                
                // rendering all the cirlces
                ForEach(0..<circleLocations.count, id: \.self){ num in
                    VertexView(
                        radius: 10,
                        color: .black,
                        coordinate: CGPoint(x: CGFloat(circleLocations[num].x), y: CGFloat(circleLocations[num].y))
                        )

                }
                
            }
        }
    }
    
    func find_node_in_circle_data(node_id: Int) -> (Int, Int){
        let location = circleLocations
        for _node in location{
            if _node.node_id == node_id{
                return (_node.x, _node.y)
            }
        }
        
        return (0, 0)
    }
    
    func update_edge_location() {
        var nodes_path: [(Int, Int, Int, Int)] = []
        let graphRepresentation = graphRepresentation
        for row in graphRepresentation{
            for node in row{
                let current_node = node.currentNode
                let previous_node = node.previousNode
                
                let current_node_loc = find_node_in_circle_data(node_id: current_node)
                let previous_node_loc = find_node_in_circle_data(node_id: previous_node)
                nodes_path.append((current_node_loc.0, current_node_loc.1, previous_node_loc.0, previous_node_loc.1))
            }
        }
        
        edgeLocation = nodes_path
    }
    
    func make_draw_node() -> [CircleData]{
        let delta_y = Int(Double(screenHeight)  / Double(graphRepresentation.count + 2)) // get the delta y distance
        let radius = delta_y / 2 - 5

        var circles: [CircleData] = []
        for i in 1...graphRepresentation.count{
            let eachRow = graphRepresentation[i - 1]
            let delta_x = Int(Double(screenWidth) / Double(eachRow.count + 1))
            
            
            for x in 1...eachRow.count{
                // rendering all of the circles
                let xPos = x * delta_x
                let yPos = i * delta_y
                circles.append(CircleData(x: xPos, y: yPos, node_id: graphRepresentation[i - 1][x - 1].currentNode))
            }
        }
        
        return circles
    }
    
    func make_graph(node_count: Int, nodes: Blackbird.LiveResults<Node>, edges: Blackbird.LiveResults<Edge>) -> [[Int]]{
        var graph: [[Int]] = []
        for i in 0...node_count{
            graph.append([])
            for _ in 0...node_count{
                graph[i].append(0)
            }
        }
        
        // loading all the nodes into a list for quick loopup
        
        for edge in edges.results{
            let from_node = edge.from_node_id
            let to_node = edge.to_node_id
            graph[from_node][to_node] = 1
        }
        
        return graph
    }
    
    func connected_node(node_id: Int, graph: [[Int]]) -> [Int]{
        var _connectedTo: [Int] = []
        var atNode = 0

        if(node_id >= graph.count){
            return []
        }
        
        for someNode in graph[node_id]{
            if someNode != 0 {
                _connectedTo.append(atNode)
            }
            atNode += 1
        }
        
        return _connectedTo
    }
    
    func makeGraphRepresentation() -> [[GraphViewRepresentationNode]] {
        // [layers][nodes]
        var graphViewRepresentation: [[GraphViewRepresentationNode]] = [[GraphViewRepresentationNode(currentNode: startNode, previousNode: startNode)]]
        let graph = graph
        
        var atLayer = 0

        while(true){
            let nextLayer = atLayer + 1
            graphViewRepresentation.append([]) // adding a empty layer for things to be pushed
            
            var should_break: Bool = true
            for _node in graphViewRepresentation[atLayer]{
                let connectedNodes = connected_node(node_id: _node.currentNode, graph: graph)
                if connectedNodes.count > 0{
                    should_break = false
                }
            }
            
            if should_break{
                break
            }
            
            for _node in graphViewRepresentation[atLayer]{
                let currentNode = _node.currentNode
                let connectedNodes = connected_node(node_id: currentNode, graph: graph)
                
                for connectedNode in connectedNodes{
                    graphViewRepresentation[nextLayer].append(GraphViewRepresentationNode(currentNode: connectedNode, previousNode: currentNode))
                }
            }
            
            
            atLayer += 1
        }
        
        graphViewRepresentation.removeLast()
        return graphViewRepresentation
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
        
        startNode = start_node
    }
}
