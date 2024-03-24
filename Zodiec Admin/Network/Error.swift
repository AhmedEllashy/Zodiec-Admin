//
//  Error.swift
//  Zodiec Admin
//
//  Created by Ahmad Ellashy on 22/03/2024.
//

import Foundation


struct CustomError {
    var id : String?
    var message : String?
    
    init(id: String?, message: String?) {
        self.id = id
        self.message = message
    }
}
