//
//  AppViewModel.swift
//  mishkaAppFinal
//
//  Created by Roman on 15.10.25.
//

import Foundation
import FirebaseAuth
import Combine

// Отслеживатель статуса авторизации при запуске

class AppViewModel: ObservableObject {
    @Published var isLoggedIn = false

    init() {
        Auth.auth().addStateDidChangeListener { _, user in
            self.isLoggedIn = user != nil
        }
    }
}


