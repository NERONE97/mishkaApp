//
//  DateTimeOption.swift
//  mishkaAppFinal
//
//  Created by Roman on 20.11.25.
//

import Foundation

struct DateTimeOption: Identifiable, Hashable {
    let id = UUID()
    let date: Date
    let time: String
}
