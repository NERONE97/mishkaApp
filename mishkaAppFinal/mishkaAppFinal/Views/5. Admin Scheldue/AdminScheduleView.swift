////
////  AdminScheduleView.swift
////  mishkaAppFinal
////
////  Created by Roman on 19.11.25.
////
//
//import SwiftUI
//import Foundation
//import Combine
//
//struct AdminScheduleView: View {
//
//    @StateObject var vm = AdminScheduleViewModel()
//    @State private var newTime = ""
//    
//    var body: some View {
//        NavigationStack {
//            Form {
//                
//                // 1. Филиал
//                Section("Филиал") {
//                    Picker("Выберите филиал", selection: $vm.selectedBranch) {
//                        ForEach(vm.branches) { b in
//                            Text(b.name).tag(Optional(b))
//                        }
//                    }
//                    .onChange(of: vm.selectedBranch) {
//                        vm.loadLessons()
//                    }
//                }
//                
//                // 2. Занятие
//                if let _ = vm.selectedBranch {
//                    Section("Занятие") {
//                        Picker("Выберите занятие", selection: $vm.selectedLesson) {
//                            ForEach(vm.lessons) { e in
//                                Text(e.name).tag(Optional(e))
//                            }
//                        }
//                    }
//                }
//                
//                // 3. Выбор даты
//                if vm.selectedLesson != nil {
//                    Section("Дата") {
//                        DatePicker(
//                            "Выберите дату",
//                            selection: $vm.selectedDate,
//                            displayedComponents: .date
//                        )
//                        .environment(\.locale, Locale(identifier: "ru_RU"))
//                    }
//                }
//                
//                // 4. Добавить время
//                if vm.selectedLesson != nil {
//                    Section("Добавить время") {
//                        HStack {
//                            TextField("Например 10:00", text: $newTime)
//                            Button("Добавить") {
//                                if !newTime.isEmpty {
//                                    vm.times.append(newTime)
//                                    newTime = ""
//                                }
//                            }
//                        }
//                        
//                        ForEach(vm.times, id: \.self) { time in
//                            Text(time)
//                        }
//                    }
//                }
//                
//                // 5. Кнопка сохранить
//                if vm.times.count > 0 {
//                    Button("Сохранить") {
//                        vm.saveSchedule()
//                    }
//                    .frame(maxWidth: .infinity)
//                }
//            }
//            .navigationTitle("Создать расписание")
//        }
//    }
//}
