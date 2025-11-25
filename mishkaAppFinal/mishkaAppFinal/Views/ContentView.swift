//
//  ContentView.swift
//  mishkaAppFinal
//
//  Created by Roman on 15.10.25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var appViewModel = AppViewModel()

    var body: some View {
        
        // Проверка на авторизацию. Авторизирован ? ТабВью : Логин
        if appViewModel.isLoggedIn {
           TabViews()
        } else {
            LoginPageView()
        }
    }
}

#Preview {
    ContentView()
}
