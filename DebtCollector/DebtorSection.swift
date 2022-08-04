//
//  DebtorSection.swift
//  DebtCollector
//
//  Created by Lem Euro on 21.07.2022.
//

import SwiftUI

struct DebtorSection: View {
    let debtors: Debtors
    let title: String
    let filteredDebtors: [Debtor]
    let deleteSouls: (IndexSet) -> Void
    
    var body: some View {
        Section(title) {
            ForEach(filteredDebtors) { soul in
                NavigationLink {
                    DebtorView(debtors: debtors, debtor: soul)
                } label : {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(soul.name)
                                .font(.headline)
                                .strikethrough(soul.status == "Killed" ? true : false)
//                            Text(soul.status)
                        }
                        
                        Spacer()
                        
                        Text(soul.debt, format: .localCurrency)
                            .strikethrough(soul.status == "Killed" ? true : false)
                            .style(for: soul)
                        
                        Text(String(Int(soul.deadlineDate.timeIntervalSince(Date.now) / 86400)))
                            .font(.caption.weight(.black))
                            .padding(5)
                            .frame(minWidth: 50)
                            .background(color(for: soul))
                            .clipShape(Capsule())
                    }
                }
            }
            .onDelete(perform: deleteSouls)
        }
    }
    
    func color(for soul: Debtor) -> Color {
        let remainingDays = Int(soul.deadlineDate.timeIntervalSince(Date.now) / 86400)
        
        if remainingDays == 0 {
            return .gray
        } else if remainingDays < 0 {
            return .red
        } else if remainingDays < 5 {
            return .orange
        } else if remainingDays < 20 {
            return .green
        } else if remainingDays < 30 {
            return .blue
        } else {
            return .indigo
        }
    }
}

struct DebtorSection_Previews: PreviewProvider {
    static var previews: some View {
        DebtorSection(debtors: Debtors(), title: "Example", filteredDebtors: []) { _ in  }
    }
}
