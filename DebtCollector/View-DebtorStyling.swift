//
//  View-DebtorStyling.swift
//  DebtCollector
//
//  Created by Lem Euro on 21.07.2022.
//

import SwiftUI

extension View {
    func style(for soul: Debtor) -> some View {
        if soul.debt < 10000 || soul.status == "Killed" {
            return self.font(.body)
        } else if soul.debt < 100000 {
            return self.font(.title3)
        } else {
            return self.font(.title)
        }
    }
}
