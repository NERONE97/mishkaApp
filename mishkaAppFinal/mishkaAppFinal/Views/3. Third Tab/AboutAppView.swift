//
//  AboutAppView.swift
//  mishkaAppFinal
//
//  Created by Roman on 16.10.25.
//

import SwiftUI

struct AboutAppView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            List {
                Section("Версия") {
                    Text("1.0.0")
                }
                
                Section("Разработчик") {
                    Text("Roman Mukhin")
                }
            }
            .navigationTitle("О приложении")
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
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Назад", systemImage: "chevron.backward") {
                        dismiss()
                    }
                }
            }
        }
    }
}
