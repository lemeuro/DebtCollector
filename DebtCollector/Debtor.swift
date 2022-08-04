//
//  Debtor.swift
//  DebtCollector
//
//  Created by Lem Euro on 21.07.2022.
//

import Foundation

struct Debtor: Identifiable, Codable, Equatable {
    var id = UUID()
    let name: String
    let status: String
    let debt: Double
    var numberOfPeople = 1
    let dealDate: Date
    let deadlineDate: Date
    let returnPercentage: Int
    var paid = 0.0
    
    static let example = Debtor(name: "Machete", status: "Active", debt: 52_432_913, dealDate: Date.now, deadlineDate: Date.now.addingTimeInterval(86400), returnPercentage: 20)
}
