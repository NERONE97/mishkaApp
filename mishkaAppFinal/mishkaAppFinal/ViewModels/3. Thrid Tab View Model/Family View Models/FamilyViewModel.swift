//
//  FamilyViewModel.swift
//  mishkaAppFinal
//
//  Created by Roman on 20.11.25.
//

import Combine
import Foundation
import FirebaseFirestore

final class FamilyViewModel: ObservableObject {
    @Published var parents: [ParentModel] = []
    @Published var children: [ChildModel] = []
    @Published var isLoading = false
    @Published var error: String?

    private let repo = FamilyRepository()
    private var userId: String?

    init(userId: String? = nil) {
        // если userId не передан, берём из Auth (если настроен)
        self.userId = userId ?? repo.currentUserId()
    }

    func setUserId(_ id: String) {
        self.userId = id
    }

    func loadAll() {
        guard let userId = userId else {
            self.error = "Пользователь не авторизован"
            return
        }
        isLoading = true
        error = nil

        let group = DispatchGroup()
        var parentsResult: Result<[ParentModel], Error>?
        var childrenResult: Result<[ChildModel], Error>?

        group.enter()
        repo.fetchParents(userId: userId) { res in
            parentsResult = res
            group.leave()
        }

        group.enter()
        repo.fetchChildren(userId: userId) { res in
            childrenResult = res
            group.leave()
        }

        group.notify(queue: .main) {
            self.isLoading = false

            switch parentsResult {
            case .success(let p): self.parents = p
            case .failure(let e): self.error = e.localizedDescription
            case .none: break
            }

            switch childrenResult {
            case .success(let c): self.children = c
            case .failure(let e): self.error = (self.error != nil ? (self.error! + "; " + e.localizedDescription) : e.localizedDescription)
            case .none: break
            }
        }
    }

    // Parents CRUD via repo
    func addParent(_ parent: ParentModel, completion: @escaping (Bool, String?) -> Void) {
        guard let userId = userId else { completion(false, "Нет userId"); return }
        repo.addParent(userId: userId, parent: parent) { err in
            DispatchQueue.main.async {
                if let err = err { completion(false, err.localizedDescription) }
                else {
                    self.loadAll()
                    completion(true, nil)
                }
            }
        }
    }

    func updateParent(_ parent: ParentModel, completion: @escaping (Bool, String?) -> Void) {
        guard let userId = userId else { completion(false, "Нет userId"); return }
        repo.updateParent(userId: userId, parent: parent) { err in
            DispatchQueue.main.async {
                if let err = err { completion(false, err.localizedDescription) }
                else {
                    self.loadAll()
                    completion(true, nil)
                }
            }
        }
    }

    func deleteParent(_ parentId: String, completion: @escaping (Bool, String?) -> Void) {
        guard let userId = userId else { completion(false, "Нет userId"); return }
        repo.deleteParent(userId: userId, parentId: parentId) { err in
            DispatchQueue.main.async {
                if let err = err { completion(false, err.localizedDescription) }
                else {
                    self.loadAll()
                    completion(true, nil)
                }
            }
        }
    }

    // Children CRUD
    func addChild(_ child: ChildModel, completion: @escaping (Bool, String?) -> Void) {
        guard let userId = userId else { completion(false, "Нет userId"); return }
        repo.addChild(userId: userId, child: child) { err in
            DispatchQueue.main.async {
                if let err = err { completion(false, err.localizedDescription) }
                else {
                    self.loadAll()
                    completion(true, nil)
                }
            }
        }
    }

    func updateChild(_ child: ChildModel, completion: @escaping (Bool, String?) -> Void) {
        guard let userId = userId else { completion(false, "Нет userId"); return }
        repo.updateChild(userId: userId, child: child) { err in
            DispatchQueue.main.async {
                if let err = err { completion(false, err.localizedDescription) }
                else {
                    self.loadAll()
                    completion(true, nil)
                }
            }
        }
    }

    func deleteChild(_ childId: String, completion: @escaping (Bool, String?) -> Void) {
        guard let userId = userId else { completion(false, "Нет userId"); return }
        repo.deleteChild(userId: userId, childId: childId) { err in
            DispatchQueue.main.async {
                if let err = err { completion(false, err.localizedDescription) }
                else {
                    self.loadAll()
                    completion(true, nil)
                }
            }
        }
    }
}
