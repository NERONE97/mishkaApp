//
//  ElectivesSelectionViewModel.swift
//  mishkaAppFinal
//
//  Created by Roman on 20.11.25.
//

import Combine
import Foundation
import FirebaseFirestore

class ElectivesSelectionViewModel: ObservableObject {
    @Published var electives: [Elective] = []
    @Published var isLoading = false
    @Published var error: String?

    private let db = Firestore.firestore()

    func load(for collectionId: String) {
        isLoading = true
        error = nil

        db.collection(collectionId).getDocuments { [weak self] snapshot, err in
            DispatchQueue.main.async {
                self?.isLoading = false

                if let err = err {
                    self?.error = err.localizedDescription
                    return
                }

                guard let snapshot else { return }

                self?.electives = snapshot.documents.compactMap { doc in
                    let data = doc.data()
                    return Elective(
                        id: doc.documentID,
                        name: data["name"] as? String ?? "",
                        info: data["info"] as? String,
                        cost: data["cost"] as? String,
                        time: data["time"] as? String
                    )
                }
            }
        }
    }
}
