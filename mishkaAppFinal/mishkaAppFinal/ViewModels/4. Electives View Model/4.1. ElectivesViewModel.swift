import Foundation
import Combine
import FirebaseFirestore

class ElectivesSearchViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var electives: [Elective] = []
    @Published var isLoading = false
    @Published var error: String? = nil

    private let db = Firestore.firestore()

    func loadElectives() {
        isLoading = true
        error = nil

        db.collection("Electives")
            .getDocuments { [weak self] snapshot, error in
                DispatchQueue.main.async {
                    self?.isLoading = false
                    if let error = error {
                        print("Ошибка при загрузке факультативов: \(error)")
                        self?.error = error.localizedDescription
                        return
                    }

                    if let snapshot = snapshot {
                        let loadedElectives = snapshot.documents.compactMap { doc in
                            let data = doc.data()
                            return Elective(
                                id: doc.documentID,
                                name: data["name"] as? String ?? "Без названия",
                                info: data["info"] as? String,
                                cost: data["cost"] as? String,
                                time: data["time"] as? String,
                            )
                        }

                        print("Загружено \(loadedElectives.count) факультативов")
                        self?.electives = loadedElectives
                    }
                }
            }
    }

    var filteredElectives: [Elective] {
        if searchText.isEmpty {
            return electives
        }
        return electives.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }
}
