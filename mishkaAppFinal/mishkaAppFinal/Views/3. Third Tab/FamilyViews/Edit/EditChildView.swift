//
//  EditChildView.swift
//  mishkaAppFinal
//
//  Created by Roman on 20.11.25.
//

import SwiftUI

struct EditChildView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var vm: ChildrenViewModel

    @State var child: Child
    @State private var showDeleteAlert = false

    var body: some View {
        Form {
            Section("Редактирование") {
                TextField("Имя", text: $child.name)
                TextField("Фамилия", text: $child.surname)
                TextField("Возраст", value: $child.age, formatter: NumberFormatter())
            }

            Button("Сохранить изменения") {
                vm.updateChild(child) { ok in
                    if ok { dismiss() }
                }
            }
            .foregroundColor(.blue)

            Button("Удалить ребёнка", role: .destructive) {
                showDeleteAlert = true
            }
        }
        .alert("Удалить ребёнка?", isPresented: $showDeleteAlert) {
            Button("Удалить", role: .destructive) {
                vm.deleteChild(child) { ok in
                    if ok { dismiss() }
                }
            }
            Button("Отмена", role: .cancel) { }
        }
        .navigationTitle(child.name)
    }
}
