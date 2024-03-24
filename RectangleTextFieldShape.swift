//
//  CustomTextField.swift
//  Zodiec Admin
//
//  Created by Ahmad Ellashy on 28/12/2023.
//

import SwiftUI

struct RectangleTextFieldShape: View {
    var height : CGFloat?
    var body: some View {
        Rectangle().fill(Color.gray.opacity(0.13)).cornerRadius(10.0)
            .frame(height:height ?? 55)
            .padding(.horizontal,10)
        
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        RectangleTextFieldShape(height: 55)
    }
}
