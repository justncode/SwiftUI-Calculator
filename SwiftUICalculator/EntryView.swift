//
//  EntryView.swift
//  SwiftUICalculator
//
//  Created by Juke Jaster on 9/4/20.
//  Copyright © 2020 Juke Jaster. All rights reserved.
//

import SwiftUI

struct EntryView: View {
    enum Entry: Hashable {
        case clear
        case negative
        case percentage
        
        case divide
        case multiply
        case subtract
        case add
        case equals
        
        case dot
        case integer(Int)
        
        var displayValue: String {
            switch self {
            case .clear:
                return "C"
            case .negative:
                return "+/-"
            case .percentage:
                return "%"
            case .divide:
                return "÷"
            case .multiply:
                return "x"
            case .subtract:
                return "-"
            case .add:
                return "+"
            case .equals:
                return "="
            case .dot:
                return "."
            case let .integer(value):
                return String(value)
            }
        }
        
        var backgroundColor: Color {
            switch self {
            case .clear,
                 .negative,
                 .percentage:
                return Color(#colorLiteral(red: 0.6470588235, green: 0.6470588235, blue: 0.6470588235, alpha: 1))
            case .divide,
                 .multiply,
                 .subtract,
                 .add,
                 .equals:
                return Color(#colorLiteral(red: 1, green: 0.6235294118, blue: 0.04705882353, alpha: 1))
            case .dot,
                 .integer:
                return Color(#colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1))
            }
        }
        
        var foregroundColor: Color {
            switch self {
            case .clear,
                 .negative,
                 .percentage:
                return .black
            default:
                return .white
            }
        }
        
        func result(from currentResult: String) -> String {
            guard isInput else {
                return performAction(on: currentResult)
            }
            
            let result = currentResult + displayValue
            
            switch (result.isDouble, result.isInteger) {
            case (false, _):
                return currentResult
            case (_, true):
                return String(Int(result) ?? 0)
            default:
                return result
            }
        }
        
        private var isInput: Bool {
            switch self {
            case .integer,
                 .dot:
                return true
            default:
                return false
            }
        }
        
        private func performAction(on currentResult: String) -> String {
            guard let doubleValue = Double(currentResult) else {
                return currentResult
            }
            
            switch self {
            case .clear:
                return String(Int.zero)
            case .negative:
                return Formatter.zeroFractionDigitsNumberFormatter.string(from: NSNumber(value: -doubleValue)) ?? currentResult
            case .percentage:
                return Formatter.zeroFractionDigitsNumberFormatter.string(from: NSNumber(value: doubleValue / 100)) ?? currentResult
            default:
                return currentResult
            }
        }
    }
    
    @Binding var result: String
    
    var body: some View {
        VStack(spacing: 0) {
            EntryRow(result: $result, entries: [.clear, .negative, .percentage, .divide])
            EntryRow(result: $result, entries: [.integer(7), .integer(8), .integer(9), .multiply])
            EntryRow(result: $result, entries: [.integer(4), .integer(5), .integer(6), .subtract])
            EntryRow(result: $result, entries: [.integer(1), .integer(2), .integer(3), .add])
            EntryRow(result: $result, entries: [.integer(0), .dot, .equals])
        }
        .padding(.bottom, 8)
    }
}

private struct EntryRow: View {
    typealias Entry = EntryView.Entry
    
    @Binding var result: String
    
    let entries: [Entry]
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                ForEach(self.entries, id: \.self) { entry in
                    self.row(for: entry, cornerRadius: geometry.cornerRadius(for: entry))
                        .frame(width: geometry.width(for: entry),
                               height: geometry.height(for: entry))
                }
            }
        }
    }
    
    private func row(for entry: Entry, cornerRadius: CGFloat) -> some View {
        Button(action: {
            self.result = entry.result(from: self.result)
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .foregroundColor(entry.backgroundColor)
                
                HStack {
                    Text(entry.displayValue)
                        .font(.title)
                        .foregroundColor(entry.foregroundColor)
                    
                    if entry == .integer(0) {
                        Spacer()
                    }
                }
                .padding()
                
            }
            .padding(.all, 4)
        }
    }
}

private extension GeometryProxy {
    typealias Entry = EntryView.Entry
    
    func height(for entry: Entry) -> CGFloat {
        size.height
    }
    
    func width(for entry: Entry) -> CGFloat {
        guard entry == .integer(0) else {
            return size.height
        }
        
        return size.height * 2
    }
    
    func cornerRadius(for entry: Entry) -> CGFloat {
        return height(for: entry) / 2
    }
}

private extension String {
    var isInteger: Bool {
        return Int(self) != nil
    }
    
    var isDouble: Bool {
        return Double(self) != nil
    }
}
