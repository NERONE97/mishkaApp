//
//  2.3. DateTimeSelectionViewModel.swift
//  mishkaAppFinal
//
//  Created by Roman on 20.11.25.
//

import Foundation
import Combine
import FirebaseFirestore

class DateTimeSelectionViewModel: ObservableObject {
    @Published var options: [DateTimeOption] = []
    @Published var isLoading = false
    @Published var error: String?

    private let db = Firestore.firestore()

    func load(branchId: String, lessonId: String) {
        isLoading = true
        error = nil

        let today = Calendar.current.startOfDay(for: Date())

        // Создаём список ближайших 14 дней
        let dates = (0..<14).compactMap { offset in
            Calendar.current.date(byAdding: .day, value: offset, to: today)
        }

        // Генерируем все возможные часы от 10 до 20
        let allTimes = (10...20).map { hour in
            String(format: "%02d:00", hour)
        }

        // 1️⃣ Загружаем все записи из bookings
        db.collection("bookings")
            .whereField("branchId", isEqualTo: branchId)
            .whereField("lessonId", isEqualTo: lessonId)
            .getDocuments { [weak self] snapshot, err in

                DispatchQueue.main.async {
                    if let err = err {
                        self?.isLoading = false
                        self?.error = err.localizedDescription
                        return
                    }

                    let booked = snapshot?.documents.compactMap { doc -> (Date, String)? in
                        guard
                            let ts = doc["date"] as? Timestamp,
                            let time = doc["time"] as? String
                        else { return nil }

                        let date = ts.dateValue()
                        return (date, time)
                    } ?? []

                    var result: [DateTimeOption] = []

                    // 2️⃣ Генерируем дату + время, исключая занятое
                    for date in dates {
                        for time in allTimes {
                            let isTaken = booked.contains { bookedDate, bookedTime in
                                Calendar.current.isDate(bookedDate, inSameDayAs: date) &&
                                bookedTime == time
                            }

                            if !isTaken {
                                result.append(DateTimeOption(date: date, time: time))
                            }
                        }
                    }

                    self?.options = result
                    self?.isLoading = false
                }
            }
    }
}
