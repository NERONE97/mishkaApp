//
//  ParentModel.swift
//  mishkaAppFinal
//
//  Created by Roman on 20.11.25.
//

import Foundation
import FirebaseFirestore

struct ParentModel: Identifiable, Hashable {
    var id: String
    var name: String
    var surname: String
    var phone: String
    var relation: String

    init(id: String = UUID().uuidString,
         name: String,
         surname: String,
         phone: String,
         relation: String) {
        self.id = id
        self.name = name
        self.surname = surname
        self.phone = phone
        self.relation = relation
    }

    init?(doc: DocumentSnapshot) {
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

    func toDict() -> [String: Any] {
        return [
            "name": name,
            "surname": surname,
            "phone": phone,
            "relation": relation
        ]
    }
}

struct ChildModel: Identifiable, Hashable {
    var id: String
    var name: String
    var surname: String
    var age: Int

    init(id: String = UUID().uuidString,
         name: String,
         surname: String,
         age: Int) {
        self.id = id
        self.name = name
        self.surname = surname
        self.age = age
    }

    init?(doc: DocumentSnapshot) {
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

    func toDict() -> [String: Any] {
        return [
            "name": name,
            "surname": surname,
            "age": age
        ]
    }
}
