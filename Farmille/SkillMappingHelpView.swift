// essa view é pra ser chamada quando o usuário clica no botão de interrogação na SkillMappingView
import SwiftUI

struct SkillmappingHelpView: View {

    var onImage = Image(systemName: "star.fill")
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20.0).frame(width: 350, height: 550).padding(.top, 5.0).foregroundColor(Color.white)

            VStack {
                Text("Skill mapping").font(.title).bold().padding()

                VStack{
                    onImage
                    Text("Não tem experiência com programação e projetos reais")
                        .multilineTextAlignment(.leading).padding()
                }.padding(.all)

                VStack{
                    HStack{
                        onImage
                        onImage
                        onImage
                    }
                    Text("Tem experiência com programação, mas não com projetos reais")
                        .multilineTextAlignment(.leading).padding()
                }.padding(.all)

                VStack{
                    HStack{
                        onImage
                        onImage
                        onImage
                        onImage
                        onImage
                    }
                    Text("Tem experiência com programação e projetos reais")
                        .multilineTextAlignment(.leading).padding()
                }.padding(.all)
            }
        }
    }
}

struct SkillmappingHelpView_Previews: PreviewProvider {
    static var previews: some View {
        SkillmappingHelpView()
    }
}
