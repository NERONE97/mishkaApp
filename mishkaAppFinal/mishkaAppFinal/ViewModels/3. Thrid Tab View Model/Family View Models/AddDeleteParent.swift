//
//  AddDeleteParent.swift
//  mishkaAppFinal
//
//  Created by Roman on 20.11.25.
//
import Combine
import Foundation
import SwiftUI
import Firebase


class ParentEditViewModel: ObservableObject {
    @Published var name = ""
    @Published var surname = ""
    @Published var phone = ""
    @Published var relation = ""

    @Published var isSaving = false
    @Published var error: String?

    private let db = Firestore.firestore()
    private let userId = "testUser"

    func save(parentId: String? = nil, completion: @escaping () -> Void) {
        isSaving = true
        error = nil

        var data: [String: Any] = [
            "name": name,
            "surname": surname,
            "phone": phone,
            "relation": relation,
            "createdAt": FieldValue.serverTimestamp()
        ]

        // Path aligned with ParentsViewModel:
        // users/{userId}/family/parents/items/{parentId}
        let parentsItems = db.collection("users")
            .document(userId)
            .collection("family")
            .document("parents")
            .collection("items")

        if let parentId = parentId, !parentId.isEmpty {
            // Update existing document
            parentsItems.document(parentId).setData(data) { [weak self] err in
                DispatchQueue.main.async {
                    if let err = err {
                        self?.error = err.localizedDescription
                    } else {
                        completion()
                    }
                    self?.isSaving = false
                }
            }
        } else {
            // Create new document with auto ID and persist id if needed
            let newDoc = parentsItems.document()
            data["id"] = newDoc.documentID
            newDoc.setData(data) { [weak self] err in
                DispatchQueue.main.async {
                    if let err = err {
                        self?.error = err.localizedDescription
                    } else {
                        completion()
                    }
                    self?.isSaving = false
                }
            }
        }
    }
}
