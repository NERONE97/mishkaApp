//
//  Elective.swift
//  mishkaAppFinal
//
//  Created by Roman on 2.11.25.
//

import Foundation

struct Elective: Identifiable, Hashable {
    let id: String              // Firestore documentId
    let name: String
    let info: String?
    let cost: String?
    let time: String?
}
