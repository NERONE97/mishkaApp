//
//  NewsPost.swift
//  mishkaAppFinal
//
//  Created by Roman on 20.11.25.
//

import Foundation
import FirebaseFirestore

struct NewsPost: Identifiable, Hashable {
    let id: String
    let title: String
    let text: String
    let timestamp: Date        // уже готовая Date

    init(id: String, title: String, text: String, timestamp: Date) {
        self.id = id
        self.title = title
        self.text = text
        self.timestamp = timestamp
    }

    init?(doc: DocumentSnapshot) {
        let data = doc.data() ?? [:]

        guard
            let title = data["title"] as? String,
            let text = data["text"] as? String,
            let ts = data["timestamp"] as? Timestamp
        else {
            print("❌ Ошибка: отсутствуют обязательные поля в документе \(doc.documentID)")
            return nil
        }

        self.id = doc.documentID
        self.title = title
        self.text = text
        self.timestamp = ts.dateValue()
    }
}



extension Date {
    func formattedRu() -> String {
        let df = DateFormatter()
        df.locale = Locale(identifier: "ru_RU")
        df.dateFormat = "d MMMM, HH:mm"   // 21 ноября, 14:35
        return df.string(from: self)
    }
}
