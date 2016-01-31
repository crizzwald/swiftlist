//
//  Models.swift
//  api
//
//  Created by Todd Crown on 1/26/16.
//  Copyright © 2016 Todd Crown. All rights reserved.
//

import Foundation
struct Models {
    struct Listing {
        var id: Int = 0;
        var title: String = "";
        var description: String = "";
        var price: Double = 0.0;
        var hiddenModelField: String = "";
        
        init(withTitle title: String, withDescription description: String, withPrice price: Double){
            self.id = 0;
            self.title = title;
            self.description = description;
            self.price = price;
            self.hiddenModelField = "Field still hidden!";
        }
    }
}
