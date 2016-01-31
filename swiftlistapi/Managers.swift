//
//  Managers.swift
//  api
//
//  Created by Todd Crown on 1/26/16.
//  Copyright © 2016 Todd Crown. All rights reserved.
//

import Foundation
struct Managers{
}

protocol ListingsManagerProtocol {
    func getListing(withId id: Int) -> Dtos.Listing;
}

extension Managers {
    struct Listings : ListingsManagerProtocol {
        func getListing(withId id: Int) -> Dtos.Listing{
            
            //go to the database and get the model, conver that to dto and return
            let modelListingItem = Models.Listing(withTitle: "TestListing", withDescription: "TestDescription", withPrice: 1.0);
            
            return modelListingItem.toDto;
        }
    }
}