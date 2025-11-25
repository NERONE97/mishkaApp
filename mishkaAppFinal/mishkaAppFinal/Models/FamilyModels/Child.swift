//
//  Child.swift
//  mishkaAppFinal
//
//  Created by Roman on 20.11.25.
//

import Foundation
import FirebaseFirestore

struct Child: Identifiable, Codable, Hashable {
    var id: String
    var name: String
    var surname: String
    var age: Int
    
    var dict: [String: Any] {
        [
            "name": name,
            "surname": surname,
            "age": age
        ]
    }
    
    init(id: String, name: String, surname: String, age: Int) {
        self.id = id
        self.name = name
        self.surname = surname
        self.age = age
    }
    
    init?(from doc: DocumentSnapshot) {
        let data = doc.data() ?? [:]
        
        guard
            let name = data["name"] as? String,
            let surname = data["surname"] as? String,
            let age = data["age"] as? Int
        else { return nil }
        
        self.id = doc.documentID
        self.name = name
        self.surname = surname
        self.age = age
    }
}
