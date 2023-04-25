//
//  Components.swift
//  Farmille
//
//  Created by Zebra on 23/04/23.
//

import SwiftUI

struct Chip: View {
    let systemImage: String  //pass system image
    let titleKey: String //text or localisation value
    let selectable: Bool = false
    
    let onAction: (String) -> Void
    
    let backgroundColor: Color = .white
    let textColor: Color = .black
    
    @State var isSelected: Bool = false
    
    var body: some View {
        let foregroundColor: Color = selectable
        ? isSelected
        ? .white
        : .blue
        : textColor
        
        let background: Color = selectable
        ? isSelected
        ? .blue
        : .white
        : backgroundColor

        HStack {
            if(systemImage != ""){
                Button(action: {
                    onAction(titleKey)
                }) {
                    Image.init(systemName: systemImage).font(.title3)
                }
            }
            Text(titleKey).font(.title3).lineLimit(1)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        .foregroundColor(foregroundColor)
        .background(background) //different UI for selected and not selected view
        .cornerRadius(40)  //rounded Corner
        .overlay(
                RoundedRectangle(cornerRadius: 40)
                    .stroke(Color.blue, lineWidth: 1.5)
        
        ).onTapGesture {
            isSelected.toggle() // toggle select - not selected
        }
    }
}
