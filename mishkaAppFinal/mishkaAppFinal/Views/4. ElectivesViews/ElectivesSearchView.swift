//
//  ElectivesView.swift
//  mishkaAppFinal
//
//  Created by Roman on 15.10.25.
//

import SwiftUI

struct ElectivesSearchView: View {
    
    @StateObject var viewModel = ElectivesSearchViewModel()

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    ZStack {
                           ProgressView("Загрузка факультативов...")
                               .frame(maxWidth: .infinity, maxHeight: .infinity)
                       }
                } else if let error = viewModel.error {
                    Text("Ошибка: \(error)")
                } else {
                    List(viewModel.filteredElectives, id: \.id) { elective in
                        VStack(alignment: .leading, spacing: 4) {
                            Text(elective.name)
                                .font(.headline)

                            if let info = elective.info {
                                Text(info)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }

                            HStack {
                                if let time = elective.time {
                                    Label(time, systemImage: "clock")
                                        .font(.caption)
                                }
                                if let cost = elective.cost {
                                    Label(cost, systemImage: "rublesign.circle")
                                        .font(.caption)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Факультативы")
            .searchable(text: $viewModel.searchText)
            .scrollContentBackground(.hidden)
            .background(
                RadialGradient(
                    gradient: Gradient(colors: [.indigo.opacity(0.5), .blue.opacity(0.6)]),
                    center: .center,
                    startRadius: 50,
                    endRadius: 600
                )
                .ignoresSafeArea()
            )
            .onAppear {
                viewModel.loadElectives()
            }
        }
    }
}

#Preview {
    ElectivesSearchView()
}
