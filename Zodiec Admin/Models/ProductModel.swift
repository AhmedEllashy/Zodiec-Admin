//
//  ProductModel.swift
//  Zodiec Admin
//
//  Created by Ahmad Ellashy on 29/12/2023.
//

import Foundation

class ProductModel {
    var id : String?
    var name : String?
    var category : String?
    var imageUrl : String?
    var price : String?
    var quantity : Int?
    var description : String?
    var sizes : [String]?
    var rate : Int?
    
    init(_data : NSDictionary){
        id = _data["id"] as? String
        name = _data["name"] as? String
        category = _data["category"] as? String
        imageUrl = _data["image"] as? String
        price = _data["price"] as? String
        quantity = _data["quantity"] as? Int
        description = _data["description"] as? String
        sizes = _data["size"] as? [String]
        rate = _data["rate"] as? Int
    }
    init(id : String? , name : String? ,category : String? ,imageUrl : String? , price : String? , quantity : Int?,description: String?, sizes : [String]? , rate : Int?){
        self.id = id
        self.name = name
        self.category = category
        self.imageUrl = imageUrl
        self.price = price
        self.quantity = quantity
        self.description = description
        self.sizes = sizes
        self.rate = rate
    }
    
}
