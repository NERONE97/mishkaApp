//
//  AddChilldView.swift
//  mishkaAppFinal
//
//  Created by Roman on 20.11.25.
//

import SwiftUI

struct AddChildView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var vm: ChildrenViewModel

    @State private var name = ""
    @State private var surname = ""
    @State private var age = ""

    var body: some View {
        Form {
            Section("Добавление ребёнка") {
                TextField("Имя", text: $name)
                TextField("Фамилия", text: $surname)
                TextField("Возраст", text: $age)
                    .keyboardType(.numberPad)
            }

            Button("Сохранить") {
                guard let ageInt = Int(age) else { return }
                let child = Child(id: UUID().uuidString, name: name, surname: surname, age: ageInt)

                vm.addChild(child) { ok in
                    if ok { dismiss() }
                }
            }
        }
        .navigationTitle("Добавить ребёнка")
    }
}
