//
//  LoginPageView.swift
//  mishkaAppFinal
//
//  Created by Roman on 15.10.25.
//

import SwiftUI

struct LoginPageView: View {
    @StateObject var viewModel = LoginViewModel()
    @FocusState private var focusedField: Field?

    enum Field {
        case login, password
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 32) {
                    Spacer()

                    // MARK: - Логотип
                    VStack(spacing: 16) {
                        
                        Text("Добро пожаловать!")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                        
                        Image("mishkaLogoVertical")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 160)
                    }

                    // MARK: - Поля ввода
                    VStack(spacing: 20) {
                        Text("Вход в аккаунт")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        VStack(spacing: 16) {
                            TextField("Email или телефон", text: $viewModel.login)
                                .padding()
                                .foregroundStyle(.primary)
                                .background(Color.white)
                                .cornerRadius(12)
                                .focused($focusedField, equals: .login)
                                .textInputAutocapitalization(.never)
                                .autocorrectionDisabled()

                            SecureField("Пароль", text: $viewModel.password)
                                .padding()
                                .foregroundStyle(.primary)
                                .background(Color.white)
                                .cornerRadius(12)
                                .focused($focusedField, equals: .password)
                                .textInputAutocapitalization(.never)
                                .autocorrectionDisabled()
                        }
                    }

                    // MARK: - Кнопки
                    VStack(spacing: 16) {
                        Button(action: {
                            viewModel.loginAction()
                        }) {
                            Text("Войти")
                                .font(.body)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(viewModel.isLoggingIn ? Color.gray : Color.indigo)
                                )
                        }
                        .buttonStyle(ScaleButtonStyle())
                        .disabled(viewModel.isLoggingIn)

                        NavigationLink(destination: RegisterView()) {
                            Text("Зарегистрироваться")
                                .font(.body)
                                .fontWeight(.semibold)
                                .foregroundColor(.indigo)
                        }

                        Button(action: {
                            // Забыли пароль
                        }) {
                            Text("Забыли пароль?")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }

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
        }
    }
}

struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
    }
}

#Preview {
    LoginPageView()
}
