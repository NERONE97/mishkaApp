//
//  AddParentView.swift
//  mishkaAppFinal
//
//  Created by Roman on 20.11.25.
//

import SwiftUI

struct AddParentView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var vm: ParentsViewModel

    @State private var name = ""
    @State private var surname = ""
    @State private var phone = ""
    @State private var relation = ""

    var body: some View {
        Form {
            Section("Данные родителя") {
                TextField("Имя", text: $name)
                TextField("Фамилия", text: $surname)
                TextField("Телефон", text: $phone)
                    .keyboardType(.phonePad)
                TextField("Степень родства", text: $relation)
            }

            Button("Сохранить") {
                let parent = Parent(
                    id: UUID().uuidString,
                    name: name,
                    surname: surname,
                    phone: phone,
                    relation: relation
                )

                vm.addParent(parent) { ok in
                    if ok { dismiss() }
                }
            }
        }
        .navigationTitle("Добавить родителя")
    }
}
