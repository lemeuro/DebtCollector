//
//  ContentView.swift
//  DebtCollector
//
//  Created by Lem Euro on 11.07.2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var debtors = Debtors()
    @State private var showingAddDebtor = false
    
    var body: some View {
        NavigationView {
            List {
                if debtors.activeSouls.isNotEmpty {
                    DebtorSection(debtors: debtors, title: "Active", filteredDebtors: debtors.activeSouls, deleteSouls: removeActiveSouls)
                }
                
                if debtors.overdueSouls.isNotEmpty {
                    DebtorSection(debtors: debtors, title: "Overdue", filteredDebtors: debtors.overdueSouls, deleteSouls: removeOverdueSouls)
                }
                
                if debtors.closedSouls.isNotEmpty {
                    DebtorSection(debtors: debtors, title: "Closed", filteredDebtors: debtors.closedSouls, deleteSouls: removeClosedSouls)
                }
                
                if debtors.killedSouls.isNotEmpty {
                    DebtorSection(debtors: debtors, title: "Killed", filteredDebtors: debtors.killedSouls, deleteSouls: removeKilledSouls)
                }
            }
            .navigationTitle("DebtCollector")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    if debtors.activeSouls.isNotEmpty || debtors.overdueSouls.isNotEmpty || debtors.closedSouls.isNotEmpty || debtors.killedSouls.isNotEmpty {
                        EditButton()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddDebtor.toggle()
                    } label: {
                        Label("Add new debtor", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddDebtor) {
                AddView(debtors: debtors)
            }
        }
    }
    
    func removeSouls(at offsets: IndexSet, in inputArray: [Debtor]) {
        var objectsToDelete = IndexSet()
        
        for offset in offsets {
            let soul = inputArray[offset]
            
            if let index = debtors.souls.firstIndex(of: soul) {
                objectsToDelete.insert(index)
            }
        }
        
        debtors.souls.remove(atOffsets: objectsToDelete)
    }
    
    func removeActiveSouls(at offsets: IndexSet) {
        removeSouls(at: offsets, in: debtors.activeSouls)
    }
    
    func removeClosedSouls(at offsets: IndexSet) {
        removeSouls(at: offsets, in: debtors.closedSouls)
    }
    
    func removeOverdueSouls(at offsets: IndexSet) {
        removeSouls(at: offsets, in: debtors.overdueSouls)
    }
    
    func removeKilledSouls(at offsets: IndexSet) {
        removeSouls(at: offsets, in: debtors.killedSouls)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
