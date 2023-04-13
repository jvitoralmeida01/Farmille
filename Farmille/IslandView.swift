//
//  IslandView.swift
//  Farmille
//
//  Created by Joao Almeida on 04/04/23.
//

import SwiftUI

struct IslandView: View {
    let rows: Int
    let cols: Int
    let imageName: String // image name
    let hide: Bool
    @State private var selectedTile = -1
    
    let height = UIScreen.main.bounds.height
    let width = UIScreen.main.bounds.width
    
    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 0), count: rows), spacing: 0) {
            ForEach(0..<(rows*cols)) { index in
                ZStack {
                    if selectedTile == index {
                        Rectangle()
                            .fill(Color.black.opacity(0.15))
                            .frame(
                                width: .infinity,
                                height: .infinity)
                            .blur(radius: 10)
                            .offset(x: 0, y: UIScreen.main.bounds.height/100)
                            .zIndex(-1)
                    }
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding(.vertical, -(height/100))
                        .padding(.horizontal, -1)
                        .offset(y: (selectedTile == index ? -height/40 : 0))
                        .onTapGesture {
                            withAnimation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0.5)) {
                                // animate changes to the imageSize state
                                selectedTile = selectedTile == index ? -1 : index
                            }
                        }
                        .zIndex(0)
                }
            }
        }
        .frame(width: 350)
    }
}

struct IslandView_Previews: PreviewProvider {
    static var previews: some View {
        IslandView(rows: 4, cols: 4, imageName: "IslandTile", hide: false)
    }
}
