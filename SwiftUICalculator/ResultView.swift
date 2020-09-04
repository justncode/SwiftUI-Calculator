//
//  ResultView.swift
//  SwiftUICalculator
//
//  Created by Juke Jaster on 9/4/20.
//  Copyright © 2020 Juke Jaster. All rights reserved.
//

import SwiftUI

struct ResultView: View {
    let geometry: GeometryProxy
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                resultText
            }
        }
        .frame(height: geometry.size.height * 0.35)
    }
    
    private var resultText: some View {
        Text("0")
            .font(.system(size: 72))
            .fontWeight(.light)
            .foregroundColor(.white)
            .padding(.trailing, 20)
    }
}
