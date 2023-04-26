//
//  Login.swift
//  TesteFoundations
//
//  Created by Vinicius Torres de Macedo on 28/03/23.
//

import Foundation
import SwiftUI
import AuthenticationServices

struct CardView: View{
    var body: some View{
        VStack{
            Text("Explore Farmille!")
                .padding(.horizontal, 30)
                .padding(.vertical, 5)
                .foregroundColor(.white)
                .bold()
                .frame(alignment: .center)
                .font(.system(size: 30))
            Text("Gerencie sua equipe de uma forma rápida e intuitiva. Crie tarefas e fique por dentro de todo o andamento do seu projeto.")
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.vertical, 5)
        }
        
    }
}


struct LoginView: View {
    @State private var title: String = ""
    @State private var index = 0
    @EnvironmentObject private var database: Database
    
    var body: some View {
        NavigationView {
            VStack {
                Image("LoginMemojis")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                TabView(selection: $index) {
                    ForEach((0..<3), id: \.self) {index in
                        CardView()
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                .frame(height: 200)
                NavigationLink(destination: SkillMappingView()) {
                    Image("LoginButtonApple")
                        .frame(alignment: .center)
                        .padding(.top, 80)
                }
            }
                .frame(maxWidth: .infinity, maxHeight: .infinity).edgesIgnoringSafeArea(.all)
                .background(LinearGradient(gradient: Gradient(colors: [.white, .blue]), startPoint: .top, endPoint: .bottom))
                .onAppear() {
                    initNotificationService()
                }
        }
    }
    
    func initNotificationService() {
        Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { _ in
            print("firing timer")
            let hardestTask = self.database.userTasks.sorted{ $0.estimate > $1.estimate }.first
            let now = Date()
            var prev = self.database.lastUpdate
            prev = prev.addingTimeInterval(10)
            if (now > prev) {
                self.database.lastUpdate = now

                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    print(success ? "Autorizado" : "Authorization failed")
                    print(error?.localizedDescription ?? "")
                }

                let content = UNMutableNotificationContent()
                content.title = "Fique de olho!"
                content.subtitle = "Atividade \(hardestTask?.title ?? "") precisa de você"
                content.body = "Entre agora!"
                content.sound = UNNotificationSound.default

                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1 , repeats: false)
                let request = UNNotificationRequest(identifier: "notif.farmille", content: content, trigger: trigger)

                UNUserNotificationCenter.current().add(request)
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environmentObject(Database(
            projects: [],
            userTasks: [],
            userRating: Rating(dev: 1, design: 1, innovation: 1)
        ))
    }
}
