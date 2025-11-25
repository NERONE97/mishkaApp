//
//  Parent.swift
//  mishkaAppFinal
//
//  Created by Roman on 20.11.25.
//

import Foundation
import FirebaseFirestore

struct Parent: Identifiable, Codable, Hashable {
    var id: String
    var name: String
    var surname: String
    var phone: String
    var relation: String
    
    var dict: [String: Any] {
        [
            "name": name,
            "surname": surname,
            "phone": phone,
            "relation": relation
        ]
    }
    
    init(id: String, name: String, surname: String, phone: String, relation: String) {
        self.id = id
        self.name = name
        self.surname = surname
        self.phone = phone
        self.relation = relation
    }
    
    init?(from doc: DocumentSnapshot) {
        let data = doc.data() ?? [:]
        
        guard
            let name = data["name"] as? String,
            let surname = data["surname"] as? String,
            let phone = data["phone"] as? String,
            let relation = data["relation"] as? String
        else { return nil }
        
        self.id = doc.documentID
        self.name = name
        self.surname = surname
        self.phone = phone
        self.relation = relation
    }
}
