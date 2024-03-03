//
//  BannerModel.swift
//  Zodiec Admin
//
//  Created by Ahmad Ellashy on 23/02/2024.
//

import Foundation


class BannerModel {
    var id : String?
    var imageUrl : String?
    
    init(_id : String?, _imageUrl : String?){
        self.id = _id
        self.imageUrl = _imageUrl
    }
    
    init(_data : NSDictionary){
        id = _data["id"] as? String
        imageUrl = _data["imageUrl"] as? String
    }
}
