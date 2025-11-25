//
//  2.4. BookingConfirmationView.swift
//  mishkaAppFinal
//
//  Created by Roman on 20.11.25.
//
import Combine
import Foundation
import FirebaseFirestore

class BookingConfirmationViewModel: ObservableObject {
    @Published var isSaving = false
    @Published var success = false
    @Published var error: String?

    private let db = Firestore.firestore()

    func save(branch: String, lessonId: String, lesson: String, date: Date, time: String) {
        isSaving = true
        error = nil

        let data: [String: Any] = [
            "branchId": branch,
            "lessonId": lessonId,
            "lesson": lesson,
            "date": Timestamp(date: date),
            "time": time
        ]

        db.collection("bookings").addDocument(data: data) { [weak self] err in
            DispatchQueue.main.async {
                self?.isSaving = false

                if let err = err {
                    self?.error = err.localizedDescription
                } else {
                    self?.success = true
                }
            }
        }
    }
}
