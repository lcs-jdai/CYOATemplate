//
//  EdgesView.swift
//  CYOATemplate
//
//  Created by Russell Gordon on 2023-06-01.
//

import Blackbird
import SwiftUI

struct EdgesView: View {
    
    // MARK: Stored properties
    
    // Needed to query database
    @Environment(\.blackbirdDatabase) var db: Blackbird.Database?
    
    // The list of edges retrieved
    @BlackbirdLiveModels var edges: Blackbird.LiveResults<Edge>
    
    // The current node that edges are being shown for.
    //
    // NOTE: This is a derived value; it points at the source of
    // truth for the current node on GameView. This allows the current
    // node to be changed from this view.
    @Binding var currentNodeId: Int
    @Binding var nodeHistories: [Int]
    
    // MARK: Computed properties
    
    // The user interface
    var body: some View {
        
        VStack(spacing: 20) {
            // Display the previous page based on the node history
            if nodeHistories.count > 1{
                // displaying the button
                HStack{
                    Spacer()
                    
                    Text(try! AttributedString(markdown: "Back"))
                        .multilineTextAlignment(.trailing)
                        .onTapGesture {
                            currentNodeId = nodeHistories[nodeHistories.count - 2]
                            nodeHistories.removeLast()
                        }
                }
            }
            
            if edges.results.count > 0 {

                ForEach(edges.results) { currentEdge in

                    HStack {
                        
                        Spacer()
                        
                        // Show a Text view, but render Markdown syntax, ignoring newlines
                        Text(try! AttributedString(markdown: currentEdge.prompt))
                            .multilineTextAlignment(.trailing)
                            .onTapGesture {
                                nodeHistories.append(currentEdge.to_node_id)
                                currentNodeId = currentEdge.to_node_id
                                
                            }

                    }

                }

            } else {
                HStack {
                    Spacer()

                    Text("No edges found for node with \(currentNodeId).")
                        .onTapGesture {
                            nodeHistories.removeAll()
                            nodeHistories.append(1)
                            currentNodeId = 1
                            
                        }
                }
            }

        }
        
    }
    
    // MARK: Initializer
    init(currentNodeId: Binding<Int>, nodeHistories: Binding<[Int]>) {
        
        // Retrieve edges for the current node in the graph
        _edges = BlackbirdLiveModels({ db in
            try await Edge.read(from: db,
                                sqlWhere: "from_node_id = ?", "\(currentNodeId.wrappedValue)")
        })
        
        // Set the current node
        _currentNodeId = currentNodeId
        _nodeHistories = nodeHistories
        
    }
}

struct EdgesView_Previews: PreviewProvider {
    static var previews: some View {

        EdgesView(currentNodeId: .constant(3), nodeHistories: .constant([3]))
        // Make the database available to all other view through the environment
        .environment(\.blackbirdDatabase, AppDatabase.instance)

    }
}
