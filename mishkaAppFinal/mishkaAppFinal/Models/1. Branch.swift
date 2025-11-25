//
//  Branch.swift
//  mishkaAppFinal
//
//  Created by Roman on 2.11.25.
//

import Foundation


struct Branch: Identifiable, Hashable {
    let id: String              // Firestore documentId
    let name: String
    let address: String?
    let phone: String?
    let email: String?
    let electivesId: String     // ссылка на коллекцию electivesBranchX
}
