//
//  OrdersViewModel.swift
//  Zodiec Admin
//
//  Created by Ahmad Ellashy on 02/03/2024.
//

import SwiftUI




@Observable
class OrdersViewModel{
    let apiManager : ApiManager?
    var orders : [OrderModel] = []
    var showAlert : Bool = false
    
    init(apiManager : ApiManager){
        self.apiManager = apiManager
    }
    func getOrders(){
        apiManager?.getOrdersApi(completion: { orders, error in
            if let orders = orders {
                self.orders = orders
            }else{
                self.showAlert = true
                print(error?.message)
                
            }
        })
    }
//    func showAlert(title : String, message : String, buttonText : String, action : () -> Void) {
//        alertProvider.alert = AlertProvider.Alert(
//            title: title,
//            message: message,
//            primaryButtomText: buttonText,
//            primaryButtonAction: action,
//            secondaryButtonText: "Cancel"
//        )
//    }
}
