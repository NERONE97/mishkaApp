import SwiftUI

struct TabViews: View {
    @StateObject var appViewModel = AppViewModel()

    var body: some View {
        TabView {

            NewsView()
                .tabItem { Label("Главная", systemImage: "house") }

            NavigationStack {
                BranchSelectionView()
            }
            .tabItem { Label("Календарь", systemImage: "calendar") }

            SettingsView()
                .environmentObject(appViewModel)
                .tabItem { Label("Настройки", systemImage: "gear") }

            ElectivesSearchView()
                .tabItem { Label("Поиск", systemImage: "magnifyingglass") }
        }
        .environmentObject(appViewModel)
    }
}

