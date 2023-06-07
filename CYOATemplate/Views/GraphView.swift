//
//  GraphView.swift
//  CYOATemplate
//
//  Created by Vincent He on 2023-06-06.
//

import SwiftUI
import Foundation

struct GraphView: View {
    var body: some View {
        ZStack(alignment: .topLeading) {
            Circle()
                .frame(width: 32, height: 32, alignment: .center)
                .offset(x: 50, y: 50)
        }
    }
}
