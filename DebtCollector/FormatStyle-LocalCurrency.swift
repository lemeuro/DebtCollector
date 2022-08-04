//
//  FormatStyle-LocalCurrency.swift
//  DebtCollector
//
//  Created by Lem Euro on 21.07.2022.
//

import Foundation

extension FormatStyle where Self == FloatingPointFormatStyle<Double>.Currency {
    static var localCurrency: Self {
        .currency(code: Locale.current.currencyCode ?? "USD")
    }
}
