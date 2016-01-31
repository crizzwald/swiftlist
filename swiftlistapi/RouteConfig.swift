//
//  RouteConfig.swift
//  api
//
//  Created by Todd Crown on 1/30/16.
//  Copyright © 2016 Todd Crown. All rights reserved.
//

import Foundation

extension ResourceConfiguration {
    func baseResources() -> [AnyObject] {
        var resources: [AnyObject] = []
        
        resources.append(ListingsController(listManagerProtocol: Managers.Listings()))
        
        return resources
    }
    
    //implement this to show routes
    func debugRoutes() -> Bool {
        return true;
    }
}