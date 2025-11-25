//
//  AddEditChildView.swift
//  mishkaAppFinal
//
//  Created by Roman on 20.11.25.
//

import SwiftUI

struct AddEditChildView: View {
    @Environment(\.dismiss) var dismiss

    @State var name: String = ""
    @State var surname: String = ""
    @State var ageText: String = ""

    var childToEdit: ChildModel?
    var onSave: (ChildModel) -> Void

    init(child: ChildModel? = nil, onSave: @escaping (ChildModel) -> Void) {
        self.childToEdit = child
        self.onSave = onSave
        _name = State(initialValue: child?.name ?? "")
        _surname = State(initialValue: child?.surname ?? "")
        _ageText = State(initialValue: child.map { String($0.age) } ?? "")
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Данные") {
                    TextField("Имя", text: $name)
                    TextField("Фамилия", text: $surname)
                    TextField("Возраст", text: $ageText)
                        .keyboardType(.numberPad)
                }
            }
            .navigationTitle(childToEdit == nil ? "Добавить ребёнка" : "Редактировать ребёнка")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Сохранить") {
                        save()
                    }
                    .disabled(name.trimmingCharacters(in: .whitespaces).isEmpty || surname.trimmingCharacters(in: .whitespaces).isEmpty || Int(ageText) == nil)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Отмена") { dismiss() }
                }
            }
        }
    }

    private func save() {
        let age = Int(ageText) ?? 0
        let model = ChildModel(
            id: childToEdit?.id ?? UUID().uuidString,
            name: name.trimmingCharacters(in: .whitespaces),
            surname: surname.trimmingCharacters(in: .whitespaces),
            age: age
        )
        onSave(model)
        dismiss()
    }
}
