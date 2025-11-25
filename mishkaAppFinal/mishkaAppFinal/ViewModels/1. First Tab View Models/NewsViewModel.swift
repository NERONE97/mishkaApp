//
//  NewsViewModel.swift
//  mishkaAppFinal
//
//  Created by Roman on 20.11.25.
//

import Combine
import Foundation
import FirebaseFirestore

class NewsViewModel: ObservableObject {
    
    @Published var posts: [NewsPost] = []
    @Published var isLoading = false
    @Published var error: String?

    private let db = Firestore.firestore()

    func loadNews() {
        isLoading = true
        error = nil

        db.collection("news")
            .order(by: "timestamp", descending: true)
            .getDocuments { [weak self] snapshot, err in
                DispatchQueue.main.async {
                    self?.isLoading = false

                    if let err = err {
                        self?.error = err.localizedDescription
                        return
                    }

                    guard let snap = snapshot else { return }

                    self?.posts = snap.documents.compactMap { NewsPost(doc: $0) }
                }
            }
    }
}
