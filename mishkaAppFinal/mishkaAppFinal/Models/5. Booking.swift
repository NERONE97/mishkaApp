//
//  5. Bookings.swift
//  mishkaAppFinal
//
//  Created by Roman on 20.11.25.
//

import Foundation
import FirebaseFirestore

struct Booking: Identifiable, Hashable {
    let id: String        // Firestore document ID
    let branchId: String
    let lessonId: String
    let lessonName: String
    let date: Date
    let time: String
    let createdAt: Date
}

extension Booking {
    init?(from doc: DocumentSnapshot) {
        let data = doc.data() ?? [:]

        guard
            let branchId = data["branchId"] as? String,
            let lessonId = data["lessonId"] as? String,
            let lessonName = data["lessonName"] as? String,
            let time = data["time"] as? String,
            let dateStamp = data["date"] as? Timestamp,
            let createdStamp = data["createdAt"] as? Timestamp
        else { return nil }

        self.id = doc.documentID
        self.branchId = branchId
        self.lessonId = lessonId
        self.lessonName = lessonName
        self.date = dateStamp.dateValue()
        self.time = time
        self.createdAt = createdStamp.dateValue()
    }
}

