//
//  ChildrenViewModel.swift
//  mishkaAppFinal
//
//  Created by Roman on 20.11.25.
//
import Combine
import Foundation
import FirebaseFirestore

class ChildrenViewModel: ObservableObject {
    @Published var children: [Child] = []
    @Published var isLoading = false
    @Published var error: String?

    private let db = Firestore.firestore()
    private let userId = "USER_ID" // Аунтифицированный

    func loadChildren() {
        isLoading = true
        db.collection("users")
            .document(userId)
            .collection("family")
            .document("children")
            .collection("items")
            .getDocuments { [weak self] snapshot, err in
                DispatchQueue.main.async {
                    self?.isLoading = false

                    if let err = err {
                        self?.error = err.localizedDescription
                        return
                    }

                    self?.children = snapshot?.documents.compactMap { Child(from: $0) } ?? []
                }
            }
    }

    func addChild(_ child: Child, completion: @escaping (Bool) -> Void) {
        db.collection("users")
            .document(userId)
            .collection("family")
            .document("children")
            .collection("items")
            .document(child.id)
            .setData(child.dict) { err in
                completion(err == nil)
            }
    }

    func updateChild(_ child: Child, completion: @escaping (Bool) -> Void) {
        db.collection("users")
            .document(userId)
            .collection("family")
            .document("children")
            .collection("items")
            .document(child.id)
            .setData(child.dict) { err in
                completion(err == nil)
            }
    }

    func deleteChild(_ child: Child, completion: @escaping (Bool) -> Void) {
        db.collection("users")
            .document(userId)
            .collection("family")
            .document("children")
            .collection("items")
            .document(child.id)
            .delete { err in
                completion(err == nil)
            }
    }
}
