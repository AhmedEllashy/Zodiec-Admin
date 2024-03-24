//
//  OrdersView.swift
//  Zodiec Admin
//
//  Created by Ahmad Ellashy on 26/01/2024.
//

import SwiftUI

struct OrdersView: View {
    @State private var  viewModel : OrdersViewModel = OrdersViewModel(apiManager: ApiManager())
    @State private var message : String = ""
    @State private var showeAlert : Bool = false
    @State private var alertState : AlertView.Sort = .loading
    var body: some View {
        NavigationView{
            ZStack {
                LazyVGrid(columns: [ GridItem(.fixed(200))], content: {
                    ForEach(viewModel.orders){order in
                        HStack {
                            Image("coupon-card")
                                .resizable()
                                .scaledToFit()
                                
                            Spacer()
                            VStack(alignment:.leading){
                                Text("$\(Int(order.total ?? 0) )")
                                Spacer()
                                Text("\(order.status ?? "")")

                            }
                            .padding()
                        }
                        .padding(.horizontal,AppSizes.s10)
                        .frame(width: UIScreen.main
                            .bounds.width - AppSizes.s20 , height : 100)
                        .foregroundStyle(Color.white)
                        .background(LinearGradient(colors: [Color.red.opacity(0.5) , Color.pink], startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(15)
                    }
                })//:VGRID
            }//:ZSTACK
            .navigationTitle("Orders")
            .navigationBarTitleDisplayMode(.large)
        }//:NAVGATION VIEW
    }
    
    init(){
        self.viewModel.getOrders()
    }

}

struct OrdersView_Previews: PreviewProvider {
    static var previews: some View {
        OrdersView()
    }
}
