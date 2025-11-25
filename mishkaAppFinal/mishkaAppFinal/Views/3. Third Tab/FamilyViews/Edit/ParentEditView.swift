//
//  ParentEditView.swift
//  mishkaAppFinal
//
//  Created by Roman on 20.11.25.
//
import SwiftUI

struct ParentEditView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var vm = ParentEditViewModel()

    let existingParent: Parent?

    var body: some View {
        Form {
            Section("Данные родителя") {
                TextField("Имя", text: $vm.name)
                TextField("Фамилия", text: $vm.surname)
                TextField("Телефон", text: $vm.phone)
                TextField("Степень родства", text: $vm.relation)
            }

            if vm.isSaving {
                ProgressView("Сохранение...")
            }

            Button("Сохранить") {
                vm.save(parentId: existingParent?.id) {
                    dismiss()
                }
            }
        }
        .navigationTitle(existingParent == nil ? "Добавить родителя" : "Редактировать родителя")
        .onAppear {
            if let p = existingParent {
                vm.name = p.name
                vm.surname = p.surname
                vm.phone = p.phone
                vm.relation = p.relation
            }
        }
    }
}
