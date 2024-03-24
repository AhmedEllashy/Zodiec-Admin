//
//  CouponModel.swift
//  Zodiec Admin
//
//  Created by Ahmad Ellashy on 09/02/2024.
//

import Foundation

struct CouponModel {
    var id : String?
    var code : String?
    var discount : Double?
    
    init(_data : NSDictionary){
        id = _data["id"] as? String
        code = _data["code"] as? String
        discount = _data["discount"] as? Double
    }
    
    init(id : String?,code : String?, discount : Double?){
        self.id = id
        self.code = code
        self.discount = discount
    }
}
