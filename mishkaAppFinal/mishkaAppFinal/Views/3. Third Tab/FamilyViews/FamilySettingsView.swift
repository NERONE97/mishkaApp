//
//  FamilySettingsView.swift
//  mishkaAppFinal
//
//  Created by Roman on 16.10.25.
//
import SwiftUI

struct FamilySettingsView: View {
    @StateObject private var vm = FamilyViewModel()
    @State private var showingAddParent = false
    @State private var showingAddChild = false

    var body: some View {
        NavigationStack {
            List {
                Section("Родители") {
                    if vm.parents.isEmpty {
                        Button("Добавить родителя") {
                            showingAddParent = true
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                    } else {
                        ForEach(vm.parents) { parent in
                            ParentCardView(parent: parent,
                                           onEdit: { p in showingEditParent(p) },
                                           onDelete: { p in confirmDeleteParent(p) })
                        }
                        Button("Добавить родителя") {
                            showingAddParent = true
                        }
                    }
                }

                Section("Дети") {
                    if vm.children.isEmpty {
                        Button("Добавить ребёнка") { showingAddChild = true }
                            .frame(maxWidth: .infinity, alignment: .center)
                    } else {
                        ForEach(vm.children) { child in
                            ChildCardView(child: child,
                                          onEdit: { c in showingEditChild(c) },
                                          onDelete: { c in confirmDeleteChild(c) })
                        }
                        Button("Добавить ребёнка") { showingAddChild = true }
                    }
                }
            }
            .navigationTitle("Моя семья")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Назад") { /* dismiss if needed */ }
                }
            }
            .sheet(isPresented: $showingAddParent) {
                AddEditParentView { newParent in
                    vm.addParent(newParent) { ok, err in
                        showingAddParent = false
                    }
                }
            }
            .sheet(isPresented: $showingAddChild) {
                AddEditChildView { newChild in
                    vm.addChild(newChild) { ok, err in
                        showingAddChild = false
                    }
                }
            }
            .onAppear { vm.loadAll() }
            .alert(item: $alertItem) { item in
                Alert(title: Text(item.title), message: Text(item.message), primaryButton: .destructive(Text("Удалить"), action: item.confirmAction), secondaryButton: .cancel())
            }
        }
    }

    // local state helpers for edit/delete flows
    @State private var editParent: ParentModel?
    @State private var editChild: ChildModel?
    @State private var alertItem: ConfirmAlert?

    private func showingEditParent(_ parent: ParentModel) {
        editParent = parent
        // show modal with AddEditParentView in edit mode
        // using .sheet or navigation, for brevity show .sheet:
        // implement similar to add with onDismiss updating
    }

    private func showingEditChild(_ child: ChildModel) {
        editChild = child
        // similar
    }

    private func confirmDeleteParent(_ parent: ParentModel) {
        alertItem = ConfirmAlert(title: "Удалить родителя?", message: "Вы уверены, что хотите удалить \(parent.name)?") {
            vm.deleteParent(parent.id) { ok, err in
                alertItem = nil
            }
        }
    }

    private func confirmDeleteChild(_ child: ChildModel) {
        alertItem = ConfirmAlert(title: "Удалить ребёнка?", message: "Вы уверены, что хотите удалить \(child.name)?") {
            vm.deleteChild(child.id) { ok, err in
                alertItem = nil
            }
        }
    }
}

// Helper for confirmation alerts
struct ConfirmAlert: Identifiable {
    let id = UUID()
    let title: String
    let message: String
    let confirmAction: () -> Void
}
