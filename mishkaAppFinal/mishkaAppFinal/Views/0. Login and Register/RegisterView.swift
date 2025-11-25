//
//  RegisterView.swift
//  mishkaAppFinal
//
//  Created by Roman on 15.10.25.
//

import SwiftUI

struct RegisterView: View {
    @StateObject var viewModel = RegisterViewModel()
    @FocusState private var focusedField: Field?
    @State private var navigateToMain = false

    enum Field {
        case name, email, password, confirmPassword
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    Spacer()

                    // MARK: - Заголовок
                    VStack(spacing: 8) {
                        Text("Регистрация")
                            .font(.largeTitle)
                            .fontWeight(.bold)

                        Text("Создайте аккаунт")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }

                    // MARK: - Поля ввода
                    VStack(spacing: 16) {
                        TextField("Ваше имя", text: $viewModel.name)
                            .padding()
                            .background(Color(UIColor.systemBackground)) // ← Вот это ключевое изменение
                            .cornerRadius(12)
                            .focused($focusedField, equals: .name)
                            .textInputAutocapitalization(.words)
                            .autocorrectionDisabled()
                           

                        TextField("Email", text: $viewModel.email)
                            .padding()
                            .background(Color(UIColor.systemBackground))
                            .cornerRadius(12)
                            .focused($focusedField, equals: .email)
                            .keyboardType(.emailAddress)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()

                        SecureField("Пароль", text: $viewModel.password)
                            .padding()
                            .background(Color(UIColor.systemBackground))
                            .cornerRadius(12)
                            .focused($focusedField, equals: .password)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()

                        SecureField("Подтвердите пароль", text: $viewModel.confirmPassword)
                            .padding()
                            .background(Color(UIColor.systemBackground))
                            .cornerRadius(12)
                            .focused($focusedField, equals: .confirmPassword)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()
                    }

                    // MARK: - Кнопка регистрации
                    Button(action: {
                        viewModel.registerAction()
                    }) {
                        Text("Зарегистрироваться")
                            .font(.body)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(viewModel.isRegistering ? Color.gray : Color.indigo)
                            )
                    }
                    .buttonStyle(ScaleButtonStyle())
                    .disabled(viewModel.isRegistering)

                    Spacer()
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 30)
            }
            .background(Color.indigo.opacity(0.5).ignoresSafeArea())
            .alert("Ошибка", isPresented: $viewModel.showError) {
                Button("OK") { }
            } message: {
                Text(viewModel.errorMessage)
            }
            .onChange(of: viewModel.goToMainScreen) { goToMain in
                if goToMain {
                    navigateToMain = true
                }
            }
            .fullScreenCover(isPresented: $navigateToMain) {
               TabViews()
            }
        }
    }
}

#Preview {
    RegisterView()
}
