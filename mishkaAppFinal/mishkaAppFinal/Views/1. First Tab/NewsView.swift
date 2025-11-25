//
//  NewsView.swift
//  mishkaAppFinal
//
//  Created by Roman on 17.10.25.
//

import SwiftUI

struct NewsView: View {
    @StateObject private var vm = NewsViewModel()

    var body: some View {
        NavigationStack {
            List {
 
                Section("Моя Семья и записи") {
                    NavigationLink(destination: FamilySettingsView().navigationBarBackButtonHidden()) {
                        HStack {
                            Label("Моя семья", systemImage: "person.3.fill")
                        }
                        .frame(minHeight: 50)
                    }
                }


                Section("Новости и обновления") {
                    if vm.isLoading {
                        ProgressView("Загрузка новостей…")
                    }
                    else if let error = vm.error {
                        Text("Ошибка: \(error)")
                            .foregroundColor(.red)
                    }
                    else if vm.posts.isEmpty {
                        Text("Новостей пока нет")
                            .foregroundColor(.secondary)
                    }
                    else {
                        ForEach(vm.posts) { post in
                            NewsCardView(post: post)
                        }
                    }
                }
            }
            .navigationTitle("Главная")
            .navigationSubtitle("Новости и обновления")
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
            .onAppear {
                vm.loadNews()
            }
        }
    }
}

#Preview {
    NewsView()
}


