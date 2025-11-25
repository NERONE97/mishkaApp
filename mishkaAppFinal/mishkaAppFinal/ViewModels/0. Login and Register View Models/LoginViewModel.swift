//
//  LoginViewModel.swift
//  mishkaAppFinal
//
//  Created by Roman on 15.10.25.
//

import Foundation
import FirebaseAuth
import SwiftUI
import Combine

class LoginViewModel: ObservableObject {
    @Published var login: String = ""
    @Published var password: String = ""
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    @Published var goToCalendar: Bool = false
    @Published var isLoggingIn: Bool = false

    func loginAction() {
        guard !login.isEmpty, !password.isEmpty else {
            showError = true
            errorMessage = "Введите логин и пароль"
            return
        }

        isLoggingIn = true

        Task {
            do {
                _ = try await Auth.auth().signIn(withEmail: login, password: password)
                await MainActor.run {
                    isLoggingIn = false
                    goToCalendar = true
                }
            } catch {
                await MainActor.run {
                    isLoggingIn = false
                    showError = true
                    errorMessage = error.localizedDescription
                }
            }
        }
    }
}
