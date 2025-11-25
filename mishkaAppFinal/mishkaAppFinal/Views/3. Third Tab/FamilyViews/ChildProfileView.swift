//
//  ChildProfileView.swift
//  mishkaAppFinal
//
//  Created by Roman on 20.11.25.
//

import SwiftUI

struct ChildProfileView: View {
    let child: Child

    var body: some View {
        Form {
            Section("Профиль") {
                Text("Имя: \(child.name)")
                Text("Фамилия: \(child.surname)")
                Text("Возраст: \(child.age) лет")
            }

            Section("Занятия") {
                Text("Скорочтение")
                Text("Английский")
                Text("Рисование")
            }
        }
        .navigationTitle(child.name)
    }
}
