//
//  BranchRoute.swift
//  mishkaAppFinal
//
//  Created by Roman on 20.11.25.
//
import Foundation

struct BranchRoute: Identifiable, Hashable {
    let id = UUID()
    let branchId: String
    let electivesId: String
}

    // 1-2
struct BookingData: Identifiable, Hashable {
    let id = UUID()
    let branchId: String
    let lessonName: String
    let lessonId: String
}

struct BookingConfirmationData: Identifiable, Hashable {
    let id = UUID()

    let branchId: String
    let lessonId: String
    let lessonName: String
    let selectedDate: Date
    let selectedTime: String
}
