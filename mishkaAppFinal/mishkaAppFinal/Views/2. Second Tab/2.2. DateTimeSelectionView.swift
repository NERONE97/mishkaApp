//
//  2.2. DateTimeSelectionView.swift
//  mishkaAppFinal
//
//  Created by Roman on 20.11.25.
//

import SwiftUI

struct DateTimeSelectionView: View {
    let branch: String
    let lesson: String
    let lessonId: String
    
    @StateObject private var vm = DateTimeSelectionViewModel()

    var body: some View {
        ZStack {
            RadialGradient(
                gradient: Gradient(colors: [.indigo.opacity(0.5), .blue.opacity(0.6)]),
                center: .center,
                startRadius: 50,
                endRadius: 600
            )
            .ignoresSafeArea()

            VStack {
                if vm.isLoading {
                    ZStack {
                        ProgressView("Загрузка свободных слотов...")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }
                else if let error = vm.error {
                    Text("Ошибка: \(error)")
                        .foregroundColor(.red)
                }
                else {
                    List {
                        Section("Выберите дату и время") {
                            ForEach(vm.options) { option in
                                NavigationLink {
                                    BookingConfirmationView(
                                        branch: branch,
                                        lessonId: lessonId,
                                        lesson: lesson,
                                        date: option.date,
                                        time: option.time
                                    )
                                } label: {
                                    VStack(alignment: .leading) {
                                        Text(option.date.formatted(date: .long, time: .omitted))
                                        Text(option.time)
                                            .foregroundColor(.secondary)
                                    }
                                }
                            }
                        }
                    }
                    .scrollContentBackground(.hidden) 
                }
            }
        }
        .navigationTitle("Дата и время")
        .onAppear {
            vm.load(branchId: branch, lessonId: lessonId)
        }
    }
}
