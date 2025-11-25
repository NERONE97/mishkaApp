//
//  SettingsView.swift
//  mishkaAppFinal
//
//  Created by Roman on 15.10.25.
//
import SwiftUI
import FirebaseAuth

struct SettingsView: View {
    @EnvironmentObject var appViewModel: AppViewModel

    var body: some View {
        NavigationView {
            List {
                // MARK: - Секция "Семья"
                Section("Семья") {
                    NavigationLink(destination: FamilySettingsView().navigationBarBackButtonHidden()) {
                        Label("Моя семья", systemImage: "person.3.fill")
                    }
                }

                // MARK: - Секция "Настройки приложения"
                Section("Настройки приложения") {
                    Toggle("Уведомления", systemImage: "bell", isOn: .constant(true))
                    
                    NavigationLink(destination: AppearanceSettingsView()) {
                        Label("Внешний вид", systemImage: "paintbrush")
                    }
                    
                    NavigationLink(destination: AboutAppView().navigationBarBackButtonHidden()) {
                        Label("О приложении", systemImage: "info.circle")
                    }
                }

                // MARK: - Секция "Аккаунт"
                Section {
                    HStack {
                        Spacer()
                        Button("Выйти") {
                            try? Auth.auth().signOut()
                            appViewModel.isLoggedIn = false
                        }
                        .multilineTextAlignment(.center)
                        .foregroundColor(.red)
                        Image(systemName: "door.left.hand.open")
                            .foregroundStyle(.red)
                        Spacer()
                    } .foregroundStyle(Color.red.opacity(0.4))
                } header: {
                    Text("Аккаунт")
                }
            }
            .navigationTitle("Настройки")
            .scrollContentBackground(.hidden)
            .background(
                RadialGradient(
                    gradient: Gradient(colors: [.indigo.opacity(0.5), .blue.opacity(0.6)]),
                    center: .center,
                    startRadius: 50,
                    endRadius: 600
                )
                .ignoresSafeArea()
            )
        }
    }
}

#Preview {
    SettingsView()
}
