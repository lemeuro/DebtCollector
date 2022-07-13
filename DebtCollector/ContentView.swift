//
//  ContentView.swift
//  DebtCollector
//
//  Created by Lem Euro on 11.07.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var debtAmount = 0.0
    @State private var debtorsNumbers = 1
    @State private var returnPercentage = 20
    @State private var debtDate = Date.now
    @State private var debtDeadline = Date.now.addingTimeInterval(2_592_000)
    @State private var totalPaid = 0.0
    @FocusState private var showingKeyboard: Bool
    
    var amountToPay: Double {
        let percentAmount = debtAmount / 100 * Double(returnPercentage)
        return percentAmount + debtAmount
    }
    
    var amountPerDebtor: Double {
        amountToPay / Double(debtorsNumbers)
    }
    
    var debtBalance: Double {
        amountToPay - totalPaid
    }
    
    var dateDifference: Int {
        let interval = debtDeadline.timeIntervalSince(debtDate)
        return Int(interval / 86400)
    }
    
    var remainingDays: Int {
        let remainingInterval = debtDeadline.timeIntervalSince(Date.now)
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
    
    let localCurrency: FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currencyCode ?? "USD")
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    HStack {
                        Text("Debt Amount:")
                        TextField("Debt amount", value: $debtAmount, format: localCurrency)
                            .keyboardType(.decimalPad)
                            .focused($showingKeyboard)
                    }
                    
                    VStack {
                        HStack {
                            Text("Number of Debtors:")
                            Spacer()
                        }
                        Picker("How many debtors?", selection: $debtorsNumbers) {
                            ForEach(1..<6, id: \.self) {
                                Text(String($0))
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                    
                    DatePicker("Deal Date", selection: $debtDate, displayedComponents: .date)
                    
                    DatePicker("Debt Deadline", selection: $debtDeadline, displayedComponents: .date)
                    
                    Picker("Return Percentage:", selection: $returnPercentage) {
                        ForEach(0..<201) {
                            Text($0, format: .percent)
                        }
                    }
                }
                
                Section {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Full amount to pay:")
                            Text(amountToPay, format: localCurrency)
                        }
                        HStack {
                            Text("Per Debtor:")
                            Text(amountPerDebtor, format: localCurrency)
                        }
                    }
                    
                    HStack {
                        Text("Number of days to pay off:")
                        Text("\(dateDifference)")
                    }
                } header: {
                    Text("Debt Summary")
                }
                
                Section {
                    HStack {
                        Text("Paid up to date:")
                        TextField("Total Paid", value: $totalPaid, format: localCurrency)
                            .keyboardType(.decimalPad)
                            .focused($showingKeyboard)
                    }
                    
                    HStack {
                        Text("Remaining Debt:")
                        Text(debtBalance, format: localCurrency)
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
            .navigationTitle("DebtCollector")
            .toolbar {
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
