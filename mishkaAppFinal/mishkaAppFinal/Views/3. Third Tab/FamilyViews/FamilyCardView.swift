//
//  FamilyCardView.swift
//  mishkaAppFinal
//
//  Created by Roman on 20.11.25.
//

import SwiftUI

struct ParentCardView: View {
    let parent: ParentModel
    var onEdit: (ParentModel) -> Void
    var onDelete: (ParentModel) -> Void

    var body: some View {
        HStack {
            Image(systemName: "person.circle.fill")
                .font(.largeTitle)
                .foregroundColor(.blue)
            VStack(alignment: .leading) {
                Text("\(parent.name) \(parent.surname)").font(.headline)
                Text(parent.relation).font(.subheadline).foregroundColor(.secondary)
                Text(parent.phone).font(.caption).foregroundColor(.secondary)
            }
            Spacer()
            Menu {
                Button("Редактировать") { onEdit(parent) }
                Button(role: .destructive) { onDelete(parent) } label: { Text("Удалить") }
            } label: {
                Image(systemName: "ellipsis.circle")
                    .font(.title2)
            }
        }
        .padding(.vertical, 8)
    }
}
