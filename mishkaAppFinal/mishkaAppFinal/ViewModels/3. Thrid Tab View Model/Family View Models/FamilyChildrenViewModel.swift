//
//  FamilyChildrenViewModel.swift
//  mishkaAppFinal
//
//  Created by Roman on 20.11.25.
//

import Foundation
import FirebaseFirestore
import Combine

class FamilyChildrenViewModel: ObservableObject {
    @Published var children: [Child] = []
    @Published var isLoading = false
    @Published var error: String?

    private let db = Firestore.firestore()
    private let userId = "testUser"  // ← подставишь реальный

    func loadChildren() {
        isLoading = true
        error = nil

        db.collection("users")
            .document(userId)
            .collection("family")
            .document("children")
            .collection("list")
            .getDocuments { [weak self] snap, err in

                DispatchQueue.main.async {
                    self?.isLoading = false

                    if let err = err {
                        self?.error = err.localizedDescription
                        return
                    }

                    self?.children = snap?.documents.compactMap { Child(from: $0) } ?? []
                }
            }
    }

    func addChild(name: String, surname: String, age: Int, completion: @escaping (Bool) -> Void) {
        let ref = db.collection("users")
            .document(userId)
            .collection("family")
            .document("children")
            .collection("list")
            .document()

        let child = Child(id: ref.documentID, name: name, surname: surname, age: age)

        ref.setData(child.dict) { err in
            DispatchQueue.main.async {
                completion(err == nil)
            }
        }
    }

    func deleteChild(_ child: Child) {
        db.collection("users")
            .document(userId)
            .collection("family")
            .document("children")
            .collection("list")
            .document(child.id)
            .delete()
    }
}
