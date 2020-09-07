//
//  Formatter.swift
//  SwiftUICalculator
//
//  Created by Juke Jaster on 9/6/20.
//  Copyright © 2020 Juke Jaster. All rights reserved.
//

import Foundation

struct Formatter {
    static var zeroFractionDigitsNumberFormatter: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.maximumFractionDigits = .max
        return numberFormatter
    }
}
