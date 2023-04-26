//
//  Components.swift
//  Farmille
//
//  Created by Zebra on 23/04/23.
//

import SwiftUI

struct FieldPresenter: View {
    let taskFields: Fields
    var body: some View {
        HStack {
            Spacer()
            HStack {
                Text("Dev").font(.title3).lineLimit(1).bold()
            }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .foregroundColor(taskFields.dev ? .white : .black.opacity(0.2))
                .background(taskFields.dev ? .blue : .gray) //different UI for selected and not selected view
                .cornerRadius(40)
            HStack {
                Text("Design").font(.title3).lineLimit(1).bold()
            }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .foregroundColor(taskFields.design ? .white : .black.opacity(0.2))
                .background(taskFields.design ? .blue : .gray) //different UI for selected and not selected view
                .cornerRadius(40)
            HStack {
                Text("Inovação").font(.title3).lineLimit(1).bold()
            }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .foregroundColor(taskFields.innovation ? .white : .black.opacity(0.2))
                .background(taskFields.innovation ? .blue : .gray) //different UI for selected and not selected view
                .cornerRadius(40)
            Spacer()
        }
    }
}

struct DificultyChip: View {
    let difficultyLevel: Int
    var body: some View {
        HStack {
            Text("Esforço estimado: \(difficultyLabel)").font(.title3).lineLimit(1)
                .bold()
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        .foregroundColor(.white)
        .background(background) //different UI for selected and not selected view
        .cornerRadius(40)  //rounded Corner
    }
    
    var difficultyLabel: String {
        switch(self.difficultyLevel) {
        case 1:
            return "Fácil"
        case 2:
            return "Médio"
        case 3:
            return "Difícil"
        default:
            return "-"
        }
    }
    
    var background: Color {
        switch(self.difficultyLevel) {
        case 1:
            return .green
        case 2:
            return .yellow
        case 3:
            return .red
        default:
            return .black
        }
    }
}

struct DificultyChip_previews: PreviewProvider {
    static var previews: some View {
        FieldPresenter(taskFields: Fields())
    }
}

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
