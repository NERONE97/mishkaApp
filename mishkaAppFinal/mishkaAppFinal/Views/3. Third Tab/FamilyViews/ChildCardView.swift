//
//  ChildCardView.swift
//  mishkaAppFinal
//
//  Created by Roman on 20.11.25.
//

import SwiftUI

struct ChildCardView: View {
    let child: ChildModel
    var onEdit: (ChildModel) -> Void
    var onDelete: (ChildModel) -> Void

    var body: some View {
        HStack {
            Image(systemName: "person.fill")
                .font(.largeTitle)
                .foregroundColor(.orange)
            VStack(alignment: .leading) {
                Text("\(child.name) \(child.surname)").font(.headline)
                Text("\(child.age) лет").font(.subheadline).foregroundColor(.secondary)
            }
            Spacer()
            Menu {
                Button("Редактировать") { onEdit(child) }
                Button(role: .destructive) { onDelete(child) } label: { Text("Удалить") }
            } label: {
                Image(systemName: "ellipsis.circle")
                    .font(.title2)
            }
        }
        .padding(.vertical, 8)
    }
}
