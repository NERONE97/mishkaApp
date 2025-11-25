//
//  AddEditParentView.swift
//  mishkaAppFinal
//
//  Created by Roman on 20.11.25.
//

import Foundation
import SwiftUI

struct AddEditParentView: View {
    @Environment(\.dismiss) var dismiss

    @State var name: String = ""
    @State var surname: String = ""
    @State var phone: String = ""
    @State var relation: String = ""

    var parentToEdit: ParentModel?
    var onSave: (ParentModel) -> Void

    init(parent: ParentModel? = nil, onSave: @escaping (ParentModel) -> Void) {
        self.parentToEdit = parent
        self.onSave = onSave
        _name = State(initialValue: parent?.name ?? "")
        _surname = State(initialValue: parent?.surname ?? "")
        _phone = State(initialValue: parent?.phone ?? "")
        _relation = State(initialValue: parent?.relation ?? "")
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Данные") {
                    TextField("Имя", text: $name)
                    TextField("Фамилия", text: $surname)
                    TextField("Телефон", text: $phone)
                        .keyboardType(.phonePad)
                    TextField("Степень родства", text: $relation)
                }
            }
            .navigationTitle(parentToEdit == nil ? "Добавить родителя" : "Редактировать родителя")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Сохранить") {
                        save()
                    }
                    .disabled(name.trimmingCharacters(in: .whitespaces).isEmpty || surname.trimmingCharacters(in: .whitespaces).isEmpty)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Отмена") { dismiss() }
                }
            }
        }
    }

    private func save() {
        let model = ParentModel(
            id: parentToEdit?.id ?? UUID().uuidString,
            name: name.trimmingCharacters(in: .whitespaces),
            surname: surname.trimmingCharacters(in: .whitespaces),
            phone: phone.trimmingCharacters(in: .whitespaces),
            relation: relation.trimmingCharacters(in: .whitespaces)
        )
        onSave(model)
        dismiss()
    }
}
