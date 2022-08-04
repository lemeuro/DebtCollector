//
//  Debtors.swift
//  DebtCollector
//
//  Created by Lem Euro on 21.07.2022.
//

import Foundation

class Debtors: ObservableObject {
    @Published var souls = [Debtor]() {
        didSet {           
            if let encoded = try? JSONEncoder().encode(souls) {
                UserDefaults.standard.set(encoded, forKey: "Souls")
            }
        }
    }
    
    var activeSouls: [Debtor] {
        souls.filter { $0.status == "Active"}
    }
    
    var closedSouls: [Debtor] {
        souls.filter { $0.status == "Closed"}
    }
    
    var overdueSouls: [Debtor] {
        souls.filter { $0.status == "Overdue"}
    }
    
    var killedSouls: [Debtor] {
        souls.filter { $0.status == "Killed"}
    }
    
    init() {
        if let saved = UserDefaults.standard.data(forKey: "Souls") {
            if let decoded = try? JSONDecoder().decode([Debtor].self, from: saved) {
                souls = decoded
                return
            }
        }
        
        souls = []
    }
}
