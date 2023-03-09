//
//  Debtor.swift
//  DebtCollector
//
//  Created by Lem Euro on 21.07.2022.
//

import Foundation

struct Debtor: Identifiable, Codable, Equatable {
    var id = UUID()
    var name: String
    var desc: String?
    var status: String
    var debt: Double
    var numberOfPeople = 1
    var dealDate: Date
    var deadlineDate: Date
    var returnPercentage: Int
    var paid = 0.0
    
    static let example = Debtor(name: "Machete", desc: "He owes me money", status: "Active", debt: 52_432_913, dealDate: Date.now, deadlineDate: Date.now.addingTimeInterval(86400), returnPercentage: 20)
}
