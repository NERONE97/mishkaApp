////
////  AdminScheduleViewModel.swift
////  mishkaAppFinal
////
////  Created by Roman on 19.11.25.
////
//
//import SwiftUI
//import FirebaseFirestore
//import Combine
//
//class AdminScheduleViewModel: ObservableObject {
//
//    @Published var branches: [Branch] = []
//    @Published var lessons: [Elective] = []
//
//    @Published var selectedBranch: Branch?
//    @Published var selectedLesson: Elective?
//    @Published var selectedDate: Date = Date()
//    @Published var times: [String] = []    // список времён, которые админ добавляет
//    
//    private let db = Firestore.firestore()
//
//    init() {
//        loadBranches()
//    }
//
//    // MARK: - Загрузить филиалы
//    func loadBranches() {
//        db.collection("branches").getDocuments { snapshot, error in
//            guard let snapshot else { return }
//            
//            let loaded = snapshot.documents.map { doc -> Branch in
//                let data = doc.data()
//                return Branch(
//                    id: doc.documentID,
//                    name: data["name"] as? String ?? "",
//                    electivesId: data["electivesId"] as? String ?? ""
//                )
//            }
//            
//            DispatchQueue.main.async {
//                self.branches = loaded
//            }
//        }
//    }
//    
//    // MARK: - Загрузить занятия выбранного филиала
//    func loadLessons() {
//        guard let branch = selectedBranch else { return }
//        
//        db.collection(branch.electivesId).getDocuments { snapshot, error in
//            guard let snapshot else { return }
//            
//            let loaded = snapshot.documents.compactMap { doc -> Elective? in
//                let d = doc.data()
//                return Elective(
//                    id: doc.documentID,
//                    name: d["name"] as? String ?? "",
//                    info: d["info"] as? String,
//                    cost: d["cost"] as? String,
//                    time: d["time"] as? String
//                )
//            }
//            
//            DispatchQueue.main.async {
//                self.lessons = loaded
//                
//                if let first = loaded.first {
//                    self.selectedLesson = first
//                }
//            }
//        }
//    }
//    
//    // MARK: - Сохранить расписание
//    func saveSchedule() {
//        guard let branch = selectedBranch else { return }
//        guard let lesson = selectedLesson else { return }
//        guard !times.isEmpty else { return }
//        
//        // Дата без времени → 00:00
//        let calendar = Calendar.current
//        let onlyDate = calendar.startOfDay(for: selectedDate)
//        
//        // Уникальный ID документа
//        let docId = "\(branch.id)_\(lesson.id)_\(formatDate(selectedDate))"
//        
//        let data: [String: Any] = [
//            "branchId": branch.id,
//            "lessonId": lesson.id,
//            "date": Timestamp(date: onlyDate),
//            "availableTimes": times.map { t in ["time": t, "booked": false] }
//        ]
//
//        db.collection("schedules").document(docId).setData(data, merge: true)
//    }
//
//    // MARK: - Форматирование даты
//    private func formatDate(_ date: Date) -> String {
//        let f = DateFormatter()
//        f.dateFormat = "yyyy-MM-dd"
//        return f.string(from: date)
//    }
//}
