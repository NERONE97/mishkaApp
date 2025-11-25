//
//  2.3. BookingConfirmationView.swift
//  mishkaAppFinal
//
//  Created by Roman on 20.11.25.
//

import SwiftUI

struct BookingConfirmationView: View {
    let branch: String
    let lessonId: String
    let lesson: String
    let date: Date
    let time: String

    @Environment(\.dismiss) var dismiss
    @StateObject private var vm = BookingConfirmationViewModel()

    var body: some View {
        ZStack {
            RadialGradient(
                gradient: Gradient(colors: [
                    .indigo.opacity(0.5),
                    .blue.opacity(0.6)
                ]),
                center: .center,
                startRadius: 50,
                endRadius: 600
            )
            .ignoresSafeArea()

            VStack(spacing: 20) {

                Text("Подтверждение записи")
                    .font(.title2)
                    .bold()
                    .padding(.top)

                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Филиал: \(branch)")
                    Text("Занятие: \(lesson)")
                    Text("Дата: \(date.formatted(date: .long, time: .omitted))")
                    Text("Время: \(time)")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(12)
                .padding(.horizontal)

                Spacer()

                
                if vm.isSaving {
                    ZStack {
                        Color.black.opacity(0.2)
                            .ignoresSafeArea()

                        ProgressView("Создание записи...")
                            .padding()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }

               
                if let error = vm.error {
                    Text("Ошибка: \(error)")
                        .foregroundColor(.red)
                        .padding(.horizontal)
                }

                
                if vm.success {
                    Text("Запись успешно создана!")
                        .foregroundColor(.green)
                        .font(.headline)

                    Button("Готово") {
                        dismiss()
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green.opacity(0.8))
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .padding(.horizontal)
                }
                else {
                    
                    Button {
                        vm.save(
                            branch: branch,
                            lessonId: lessonId,
                            lesson: lesson,
                            date: date,
                            time: time
                        )
                    } label: {
                        Text("Подтвердить")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                }

                Spacer(minLength: 30)
            }
        }
    }
}
