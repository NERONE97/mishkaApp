//
//  BranchViewModel.swift
//  mishkaAppFinal
//
//  Created by Roman on 2.11.25.
//

import Foundation
import Combine
import FirebaseFirestore


class BranchViewModel: ObservableObject {
    @Published var branches: [Branch] = []
    @Published var isLoading = false
    @Published var error: String?
    
    private let db = Firestore.firestore()
    
    func loadBranches() {
        isLoading = true
        error = nil
        
        db.collection("branches")
            .getDocuments { [weak self] snapshot, err in
                DispatchQueue.main.async {
                    self?.isLoading = false
                    
                    if let err = err {
                        self?.error = err.localizedDescription
                        return
                    }
                    
                    guard let snapshot else { return }
                    
                    self?.branches = snapshot.documents.compactMap { doc in
                        let data = doc.data()
                        
                        return Branch(
                            id: doc.documentID,
                            name: data["name"] as? String ?? "Без названия",
                            address: data["address"] as? String,
                            phone: data["phone"] as? String,
                            email: data["email"] as? String,
                            electivesId: data["electivesId"] as? String ?? ""
                        )
                    }
                }
            }
    }
}
