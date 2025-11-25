//
//  ParentViewModel.swift
//  mishkaAppFinal
//
//  Created by Roman on 20.11.25.
//
import Combine
import Foundation
import FirebaseFirestore
import FirebaseAuth


class ParentViewModel: ObservableObject {
    @Published var parents: [Parent] = []
    @Published var isLoading = false
    @Published var error: String?
    
    private let db = Firestore.firestore()
    
    // userId
    private var userId: String? {
        Auth.auth().currentUser?.uid
    }
    
    // список родителей
    func loadParents() {
        guard let userId = userId else {
            self.error = "Пользователь не найден"
            return
        }
        
        isLoading = true
        error = nil
        
        db.collection("users")
            .document(userId)
            .collection("family")
            .document("parents")
            .collection("items")
            .addSnapshotListener { [weak self] snapshot, err in
                guard let self else { return }
                
                if let err = err {
                    self.error = err.localizedDescription
                    self.isLoading = false
                    return
                }
                
                guard let docs = snapshot?.documents else {
                    self.isLoading = false
                    return
                }
                
                // Use Parent's failable initializer `init?(from:)`
                self.parents = docs.compactMap { Parent(from: $0) }
                self.isLoading = false
            }
    }
    
    // Добавить родителя
    func addParent(name: String, surname: String, phone: String, relation: String, completion: @escaping (Bool) -> Void) {
        guard let userId = userId else { return }
        
        let data: [String: Any] = [
            "name": name,
            "surname": surname,
            "phone": phone,
            "relation": relation
        ]
        
        db.collection("users")
            .document(userId)
            .collection("family")
            .document("parents")
            .collection("items")
            .addDocument(data: data) { err in
                if let err = err {
                    print("Ошибка добавления родителя: \(err.localizedDescription)")
                    completion(false)
                } else {
                    completion(true)
                }
            }
    }
    
    // Обнулить родителя
    func updateParent(parentId: String, name: String, surname: String, phone: String, relation: String, completion: @escaping (Bool) -> Void) {
        guard let userId = userId else { return }
        
        let data: [String: Any] = [
            "name": name,
            "surname": surname,
            "phone": phone,
            "relation": relation
        ]
        
        db.collection("users")
            .document(userId)
            .collection("family")
            .document("parents")
            .collection("items")
            .document(parentId)
            .updateData(data) { err in
                completion(err == nil)
            }
    }
    
    // Удалить
    func deleteParent(parentId: String, completion: @escaping (Bool) -> Void) {
        guard let userId = userId else { return }

        db.collection("users")
            .document(userId)
            .collection("family")
            .document("parents")
            .collection("items")
            .document(parentId)
            .delete { err in
                completion(err == nil)
            }
    }
}
