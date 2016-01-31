//
//  Dtos.swift
//  api
//
//  Created by Todd Crown on 1/26/16.
//  Copyright © 2016 Todd Crown. All rights reserved.
//

import Foundation

struct Dtos {
    struct Listing {
        var id: Int = 0;
        var title: String = "";
        var description: String = "";
        var price: Double = 0.0;
        
        init(withTitle title: String, withDescription description: String, withPrice price: Double){
            self.id = 0;
            self.title = title;
            self.description = description;
            self.price = price;
        }
    }
}