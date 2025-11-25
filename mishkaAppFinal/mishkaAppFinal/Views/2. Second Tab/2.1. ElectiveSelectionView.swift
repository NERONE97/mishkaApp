import SwiftUI

struct ElectivesSelectionView: View {
    let branchId: String
    let electivesId: String

    @StateObject private var vm = ElectivesSelectionViewModel()

    var body: some View {
        VStack {
            if vm.isLoading {
                ZStack {
                       ProgressView("Загрузка факультативов...")
                           .frame(maxWidth: .infinity, maxHeight: .infinity)
                   }
            }
            else if let error = vm.error {
                Text("Ошибка: \(error)")
                    .foregroundColor(.red)
            }
            else {
                List(vm.electives) { e in
                    NavigationLink {
                        DateTimeSelectionView(
                            branch: branchId,
                            lesson: e.name,
                            lessonId: e.id
                        )
                    } label: {
                        VStack(alignment: .leading) {
                            Text(e.name)
                                .font(.headline)

                            if let info = e.info {
                                Text(info)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Факультативы")
        .navigationSubtitle("Выберите свой факультатив")
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
            vm.load(for: electivesId)
        }
    }
}
