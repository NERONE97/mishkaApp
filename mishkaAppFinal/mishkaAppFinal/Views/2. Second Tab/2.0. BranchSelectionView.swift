import SwiftUI

struct BranchSelectionView: View {
    @StateObject var vm = BranchViewModel()

    var body: some View {
        ZStack {
            
            RadialGradient(
                gradient: Gradient(colors: [.indigo.opacity(0.5), .blue.opacity(0.6)]),
                center: .center,
                startRadius: 50,
                endRadius: 600
            )
            .ignoresSafeArea()

            // --- Основной контент
            Group {
                if vm.isLoading {
                    ProgressView("Загрузка филиалов...")
                }
                else if let error = vm.error {
                    Text("Ошибка: \(error)").foregroundColor(.red)
                }
                else {
                    List(vm.branches) { branch in
                        NavigationLink {
                            ElectivesSelectionView(
                                branchId: branch.id,
                                electivesId: branch.electivesId
                            )
                        } label: {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(branch.name).font(.headline)
                                if let address = branch.address {
                                    Text(address)
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                    }
                    
                    .scrollContentBackground(.hidden)
                }
            }
        }
        .navigationTitle("Филиалы")
        .onAppear {
            vm.loadBranches()
        }
    }
}
