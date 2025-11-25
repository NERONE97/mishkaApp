//
//  FamilyReposit.swift
//  mishkaAppFinal
//
//  Created by Roman on 20.11.25.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

final class FamilyRepository {
    private let db = Firestore.firestore()

    // Получить userId: сначала Auth, иначе nil
    func currentUserId() -> String? {
        return Auth.auth().currentUser?.uid
    }

    // CRUD parents
    func parentsCollection(for userId: String) -> CollectionReference {
        return db.collection("users").document(userId).collection("family").document("root").collection("parents")
    }

    func childrenCollection(for userId: String) -> CollectionReference {
        return db.collection("users").document(userId).collection("family").document("root").collection("children")
    }

    func fetchParents(userId: String, completion: @escaping (Result<[ParentModel], Error>) -> Void) {
        parentsCollection(for: userId).getDocuments { snap, err in
            if let err = err { completion(.failure(err)); return }
            let list = snap?.documents.compactMap { ParentModel(doc: $0) } ?? []
            completion(.success(list))
        }
    }

    func fetchChildren(userId: String, completion: @escaping (Result<[ChildModel], Error>) -> Void) {
        childrenCollection(for: userId).getDocuments { snap, err in
            if let err = err { completion(.failure(err)); return }
            let list = snap?.documents.compactMap { ChildModel(doc: $0) } ?? []
            completion(.success(list))
        }
    }

    func addParent(userId: String, parent: ParentModel, completion: @escaping (Error?) -> Void) {
        parentsCollection(for: userId).document(parent.id).setData(parent.toDict(), completion: completion)
    }

    func updateParent(userId: String, parent: ParentModel, completion: @escaping (Error?) -> Void) {
        parentsCollection(for: userId).document(parent.id).updateData(parent.toDict(), completion: completion)
    }

    func deleteParent(userId: String, parentId: String, completion: @escaping (Error?) -> Void) {
        parentsCollection(for: userId).document(parentId).delete(completion: completion)
    }

    func addChild(userId: String, child: ChildModel, completion: @escaping (Error?) -> Void) {
        childrenCollection(for: userId).document(child.id).setData(child.toDict(), completion: completion)
    }

    func updateChild(userId: String, child: ChildModel, completion: @escaping (Error?) -> Void) {
        childrenCollection(for: userId).document(child.id).updateData(child.toDict(), completion: completion)
    }

    func deleteChild(userId: String, childId: String, completion: @escaping (Error?) -> Void) {
        childrenCollection(for: userId).document(childId).delete(completion: completion)
    }
}
