//
//  ParentSvm.swift
//  mishkaAppFinal
//
//  Created by Roman on 20.11.25.
//
import Combine
import Foundation
import FirebaseFirestore
import FirebaseAuth


class ParentsViewModel: ObservableObject {
    @Published var parents: [Parent] = []
    @Published var isLoading = false
    @Published var error: String?

    private let db = Firestore.firestore()
    private let userId = "USER_ID"

    func loadParents() {
        isLoading = true
        db.collection("users")
            .document(userId)
            .collection("family")
            .document("parents")
            .collection("items")
            .getDocuments { [weak self] snapshot, err in
                DispatchQueue.main.async {
                    self?.isLoading = false

                    if let err = err {
                        self?.error = err.localizedDescription
                        return
                    }

                    self?.parents = snapshot?.documents.compactMap { Parent(from: $0) } ?? []
                }
            }
    }

    func addParent(_ parent: Parent, completion: @escaping (Bool) -> Void) {
        db.collection("users")
            .document(userId)
            .collection("family")
            .document("parents")
            .collection("items")
            .document(parent.id)
            .setData(parent.dict) { err in
                completion(err == nil)
            }
    }

    func updateParent(_ parent: Parent, completion: @escaping (Bool) -> Void) {
        db.collection("users")
            .document(userId)
            .collection("family")
            .document("parents")
            .collection("items")
            .document(parent.id)
            .setData(parent.dict) { err in
                completion(err == nil)
            }
    }

    func deleteParent(_ parent: Parent, completion: @escaping (Bool) -> Void) {
        db.collection("users")
            .document(userId)
            .collection("family")
            .document("parents")
            .collection("items")
            .document(parent.id)
            .delete { err in
                completion(err == nil)
            }
    }
}
