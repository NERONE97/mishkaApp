//
//  EditParentView.swift
//  mishkaAppFinal
//
//  Created by Roman on 20.11.25.
//

import SwiftUI

struct EditParentView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var vm: ParentsViewModel

    @State var parent: Parent
    @State private var showDelete = false

    var body: some View {
        Form {
            Section("Редактирование") {
                TextField("Имя", text: $parent.name)
                TextField("Фамилия", text: $parent.surname)
                TextField("Телефон", text: $parent.phone)
                TextField("Родство", text: $parent.relation)
            }

            Button("Сохранить") {
                vm.updateParent(parent) { ok in
                    if ok { dismiss() }
                }
            }

            Button("Удалить родителя", role: .destructive) {
                showDelete = true
            }
        }
        .alert("Удалить родителя?", isPresented: $showDelete) {
            Button("Удалить", role: .destructive) {
                vm.deleteParent(parent) { ok in
                    if ok { dismiss() }
                }
            }
            Button("Отмена", role: .cancel) {}
        }
        .navigationTitle(parent.name)
    }
}
