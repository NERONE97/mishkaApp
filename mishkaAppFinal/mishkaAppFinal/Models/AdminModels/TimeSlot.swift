//
//  TimeSlot.swift
//  mishkaAppFinal
//
//  Created by Roman on 19.11.25.
//

import SwiftUI
import Foundation

struct TimeSlot: Identifiable, Codable {
    var id = UUID().uuidString
    var time: String
    var booked: Bool
}

struct ScheduleDay: Identifiable, Codable {
    var id: String
    var branchId: String
    var lessonId: String
    var date: Date
    var availableTimes: [TimeSlot]
}

