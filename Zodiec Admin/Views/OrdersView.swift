//
//  OrdersView.swift
//  Zodiec Admin
//
//  Created by Ahmad Ellashy on 26/01/2024.
//

import SwiftUI

struct OrdersView: View {
    @State private var orders : [OrderModel] = []
    var body: some View {
        NavigationView{
                List (orders) { order in
                    VStack(spacing : AppSizes.s20){
                        HStack {
                            Text(order.id)
                                .font(.system(.title3))
                                .foregroundColor(.black)
                            Text("$\(order.total)")
                                .font(.system(.title3))
                                .foregroundColor(.black)
                        }
                    }
                }//:List
        }//:NAVGATION VIEW
    }
}

struct OrdersView_Previews: PreviewProvider {
    static var previews: some View {
        OrdersView()
    }
}
