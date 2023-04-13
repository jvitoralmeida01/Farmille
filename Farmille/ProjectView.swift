//
//  ProjectView.swift
//  Farmille
//
//  Created by Joao Almeida on 04/04/23.
//

import SwiftUI

struct ProjectView: View {
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [Color.white, Color.blue]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                    .overlay(
                        VStack {
                        IslandView(rows: 4, cols: 5, imageName: "IslandTile", hide: false)
                        }
                        .padding(.horizontal, 50)
                    )
    }
}

struct ProjectView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectView()
    }
}
