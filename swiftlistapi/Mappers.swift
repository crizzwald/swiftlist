//
//  ListMapper.swift
//  api
//
//  Created by Todd Crown on 1/26/16.
//  Copyright © 2016 Todd Crown. All rights reserved.
//

import Foundation

// MARK: List extensions
extension Models.Listing {
    var toDto: Dtos.Listing {
        let dto = Dtos.Listing(withTitle: self.title, withDescription: self.description, withPrice: self.price);
        return dto;
    }
}
//MARK: -
//MARK: List Dto extensions
extension Dtos.Listing {
    var toModel: Models.Listing {
        let model = Models.Listing(withTitle: self.title, withDescription: self.description, withPrice: self.price);
        return model;
    }
}