//
//  AddView.swift
//  DebtCollector
//
//  Created by Lem Euro on 21.07.2022.
//

import SwiftUI

struct AddView: View {
    @ObservedObject var debtors: Debtors
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var desc = ""
    @State private var status = "Active"
    @State private var debt = 0.0
    @State private var numberOfPeople = 1
    @State private var dealDate = Date.now
    @State private var deadlineDate = Date.now.addingTimeInterval(2_592_000)
    @State private var returnPercentage = 20
    @State private var paid = 0.0
    @FocusState private var showingKeyboard: Bool
    
    let statuses = ["Active", "Closed", "Overdue", "Killed"]
    
    var amountToPay: Double {
        let percentAmount = debt / 100 * Double(returnPercentage)
        return percentAmount + debt
    }
    
    var amountPerDebtor: Double {
        amountToPay / Double(numberOfPeople)
    }
    
    var debtBalance: Double {
        amountToPay - paid
    }
    
    var dateDifference: Int {
        let interval = deadlineDate.timeIntervalSince(dealDate)
        return Int(interval / 86400)
    }
    
    var remainingDays: Int {
        let remainingInterval = deadlineDate.timeIntervalSince(Date.now)
        return Int(remainingInterval / 86400)
    }
        
    var whatToDo: String {
        if remainingDays < -30 && debtBalance > 0 {
            return "Kill the debtor!"
        } else if remainingDays <= 0 && debtBalance > 0 {
            return "Time is Up. Reach out to the debtor and give him a thrashing."
        } else {
            return "Relax. You have passive income."
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name", text: $name)
                        .keyboardType(.alphabet)
                        .focused($showingKeyboard)
                    
                    TextField("Description", text: $desc)
                        .focused($showingKeyboard)
                    
                    HStack {
                        Text("Debt Amount:")
                        TextField("Debt amount", value: $debt, format: .localCurrency)
                            .keyboardType(.decimalPad)
                            .focused($showingKeyboard)
                    }
                    
                    VStack {
                        HStack {
                            Text("Number of Debtors:")
                            Spacer()
                        }
                        Picker("How many debtors?", selection: $numberOfPeople) {
                            ForEach(1..<6, id: \.self) {
                                Text(String($0))
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                    
//                    DatePicker("Deal Date", selection: $dealDate, in: Date.now...Date.now.addingTimeInterval(172_800),  displayedComponents: .date)
                    DatePicker("Deal Date", selection: $dealDate, displayedComponents: .date)
                    
                    DatePicker("Debt Deadline", selection: $deadlineDate, in: dealDate..., displayedComponents: .date)
                    
                    Picker("Return Percentage:", selection: $returnPercentage) {
                        ForEach(0..<201) {
                            Text($0, format: .percent)
                        }
                    }
                    
                    Picker("Status", selection: $status) {
                        ForEach(statuses, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Full amount to pay:")
                            Text(amountToPay, format: .localCurrency)
                        }
                        if numberOfPeople > 1 {
                            HStack {
                                Text("Per Debtor:")
                                Text(amountPerDebtor, format: .localCurrency)
                            }
                        }
                    }
                    
                    HStack {
                        Text("Days to pay off:")
                        Text("\(dateDifference)")
//                        Text(deadlineDate, format: .dateTime.hour().minute())
                    }
                } header: {
                    Text("Debt Summary")
                }
                
                Section {
                    HStack {
                        Text("Paid up to date:")
                        TextField("Total Paid", value: $paid, format: .localCurrency)
                            .keyboardType(.decimalPad)
                            .focused($showingKeyboard)
                    }
                    
                    HStack {
                        Text("Remaining Debt:")
                        Text(debtBalance, format: .localCurrency)
                    }
                    
                    HStack {
                        Text("Remaining Days to Pay All:")
                        Text("\(remainingDays)")
                            .foregroundColor(remainingDays < 0 ? .red : .primary)
                        
                    }
                }
                
                Text(whatToDo)
                    .foregroundColor(remainingDays > 0 ? .green : remainingDays <= 0 && debtBalance > 0 ? .red : .green)
            
            }
            .navigationTitle("Add Debtor")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        let trimmedName = name.trimmingCharacters(in: .whitespaces)
                        guard trimmedName.isEmpty == false else { return }
                        
                        let soul = Debtor(name: name, desc: desc, status: status, debt: debt, numberOfPeople: numberOfPeople, dealDate: dealDate, deadlineDate: deadlineDate, returnPercentage: returnPercentage, paid: paid)
                        debtors.souls.append(soul)
                        dismiss()
                    }
                }
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        showingKeyboard = false
                    }
                }
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(debtors: Debtors())
    }
}
