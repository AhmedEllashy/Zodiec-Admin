//
//  CategoryModel.swift
//  Zodiec Admin
//
//  Created by Ahmad Ellashy on 23/01/2024.
//

import SwiftUI

class CategoryModel{
    var id : String?
    var name : String?
    var imageUrl : String?
    
    init(_data : NSDictionary){
        id = _data["id"] as? String
        name = _data["name"] as? String
        imageUrl = _data["imageUrl"] as? String
    }
    init(id : String?,name: String?,imageUrl : String?){
        self.id = id
        self.name = name
        self.imageUrl = imageUrl
    }
}

