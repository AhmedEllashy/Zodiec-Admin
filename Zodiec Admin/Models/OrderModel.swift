//
//  OrderModel.swift
//  Zodiec Admin
//
//  Created by Ahmad Ellashy on 02/03/2024.
//
import SwiftUI
import FirebaseFirestore
class OrderModel : Identifiable{
    var orderId : String?
    var products : [CartModel]?
    var total : Double?
    var status : String?
    var date : Timestamp?
    var subtotal : Double?
    var discount : Double?
    
    init(_data : NSDictionary){
        orderId = _data["id"] as? String
        var temp : [CartModel] = []
        for item in _data["products"] as! Array<Any> {
            temp.append(CartModel(_data: item as! NSDictionary))
        }
        products = temp
        total = _data["total"] as? Double
        status = _data["status"] as? String
        date = _data["date"] as? Timestamp
        subtotal = _data["subtotal"] as? Double
        discount = _data["discount"] as? Double

    }
    init(id : String ,products : [CartModel]? ,total : Double? ,status : String? ,date : Timestamp?,subtotal : Double?, discount : Double?){
        self.products = products
        self.total = total
        self.status = status
        self.date = date
        self.subtotal = subtotal
        self.discount = discount
        
    }
}
