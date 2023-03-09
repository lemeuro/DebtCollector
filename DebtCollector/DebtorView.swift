//
//  DebtorView.swift
//  DebtCollector
//
//  Created by Lem Euro on 30.07.2022.
//

import SwiftUI

struct DebtorView: View {
    @ObservedObject var debtors: Debtors
    var debtor: Debtor
    
    var body: some View {
        Form {
            Section {
                Text(debtor.name)
                
                if let desc = debtor.desc {
                    Text(desc)
                }
                
                HStack {
                    Text("Paid:")
                    Text(debtor.paid, format: .localCurrency)
                }
            }
            
            Section {
                Button("Add 100 to paid balance") {
                    var newDebtor = debtor
                    newDebtor.paid += 100
                    
                    if let index = debtors.souls.firstIndex(of: debtor) {
                        debtors.souls[index] = newDebtor
                    }
                }
            }
        }
        .navigationTitle(debtor.name)
    }
}

struct DebtorView_Previews: PreviewProvider {
    static var previews: some View {
        DebtorView(debtors: Debtors(), debtor: Debtor.example)
    }
}
