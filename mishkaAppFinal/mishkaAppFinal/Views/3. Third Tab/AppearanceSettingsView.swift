//
//  Untitled.swift
//  mishkaAppFinal
//
//  Created by Roman on 16.10.25.
//

import SwiftUI

struct AppearanceSettingsView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false

    var body: some View {
        List {
            Toggle("Тёмная тема", isOn: $isDarkMode)
        }
        .navigationTitle("Внешний вид")
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
