//
//  InstructionsView.swift
//  skillmapping_info
//
//  View para avisar ao usuário sobre o skillmapping 
//
//  Created by Rodrigo Barbosa de Oliveira on 10/04/23.
//

import SwiftUI

struct InstructionsView: View {
    @State var number: Int = 1
    var body: some View {
        let shape = RoundedRectangle(cornerRadius: 20.0).frame(width: 350, height: 550)
        ZStack{
            
            LinearGradient(gradient: Gradient(stops: [
                .init(color: .white, location: 0),
                .init(color: .blue, location: 0.4)
            ]), startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
            
            VStack{
                ZStack{
                    shape.foregroundColor(Color(hue: 1.0, saturation: 0.0, brightness: 0.921)).padding()
                    VStack{
                        VStack{
                            Text("Queremos saber mais sobre você!").font(.title).fontWeight(.semibold).multilineTextAlignment(.center)
                        }
                        VStack{
                            Text("Para ajudar na organização dos seus grupos e projetos, precisamos da sua autoavaliação em 3 principais áreas de conhecimento: Desenvolvimento, Design e Inovação").multilineTextAlignment(.center).padding([.top, .leading, .trailing], 40.0).font(Font.custom("Inter", size: 25))
                        }
                    }

                }
                
                Button(action: {
                    // Adicione aqui o código a ser executado quando o botão for pressionado
                }) {
                Text("Continuar")
                    .font(.headline)
                    .foregroundColor(.blue)
                    .padding(.vertical, 20)
                    .padding(.horizontal, 40)
                    .background(Color.white.cornerRadius(20))
                }
                .padding()
            }
        }
    }
}
struct InstructionsView_Previews: PreviewProvider {
    static var previews: some View {
        InstructionsView()
    }
}
