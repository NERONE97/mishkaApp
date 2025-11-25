//
//  RegisterViewModel.swift
//  mishkaAppFinal
//
//  Created by Roman on 15.10.25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import Combine

class RegisterViewModel: ObservableObject {
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    @Published var showError = false
    @Published var errorMessage = ""
    @Published var goToMainScreen = false
    @Published var isRegistering = false

    func registerAction() {
        guard !name.isEmpty, !email.isEmpty, !password.isEmpty, !confirmPassword.isEmpty else {
            showError = true
            errorMessage = "Пожалуйста, заполните все поля"
            return
        }

        guard password == confirmPassword else {
            showError = true
            errorMessage = "Пароли не совпадают"
            return
        }

        isRegistering = true

        Task {
            do {
                // Регистрация пользователя
                let authResult = try await Auth.auth().createUser(withEmail: email, password: password)

                // Сохранение данных пользователя в Firestore
                let userRef = Firestore.firestore().collection("users").document(authResult.user.uid)
                try await userRef.setData([
                    "name": name,
                    "email": email
                ])

                await MainActor.run {
                    isRegistering = false
                    goToMainScreen = true
                }
            } catch {
                await MainActor.run {
                    isRegistering = false
                    showError = true
                    errorMessage = error.localizedDescription
                }
            }
        }
    }
}
