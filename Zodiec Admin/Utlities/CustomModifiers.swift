//
//  CustomModifiers.swift
//  Zodiec Admin
//
//  Created by Ahmad Ellashy on 15/01/2024.
//

import SwiftUI

struct ErrorTextModifier : ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title2)
            .foregroundColor(.red)
    }
}

