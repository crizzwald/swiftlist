//
//  ListController.swift
//  api
//
//  Created by Todd Crown on 1/27/16.
//  Copyright © 2016 Todd Crown. All rights reserved.
//

import Foundation


//public func PerfectServerModuleInit() {
//    
//    // Install the built-in routing handler.
//    // Using this system is optional and you could install your own system if desired.
//    Routing.Handler.registerGlobally()
//    let manager = Managers.List()
//    let routes = ListController(listManagerProtocol: manager).routes
//    
//    for(route, obj) in routes {
//        let val = obj as! (verb: String, method: (WebRequest, WebResponse) -> ())
//        Routing.Routes[val.verb, route] = { _ in return ListController(listManagerProtocol: manager) }
//    }
//}

//struct ListController: RequestHandler {
//    var routes: [String:Any] = [:]
//    private var _listManagerProtocol: ListManagerProtocol
//    
//    init(listManagerProtocol: ListManagerProtocol) {
//        //inject instance of listManager
//        _listManagerProtocol = listManagerProtocol
//        
//        //configure routes
//        routes["/getlistitem"] = (verb: "GET", method: getListItem)
//    }
//    
//    func getListItem(request: WebRequest, response: WebResponse) {
//        let list = _listManagerProtocol.getList();
//
//        response.appendBodyString("List Title: \(list.title)")
//    }
//    
//    func handleRequest(request: WebRequest, response: WebResponse) {
//        //call func for request
//        let obj = routes[request.requestURI()]!
//        let val = obj as! (verb: String, method: (WebRequest, WebResponse) -> ())
//        val.method(request, response);
//        
//        response.requestCompletedCallback();
//    }
//}

class ListingsController : ApiController {
    var routePrefix = "listings"
    var resources = [ApiResource]()
    private var _listManagerProtocol: ListingsManagerProtocol
    
    init(listManagerProtocol: ListingsManagerProtocol) {
        _listManagerProtocol = listManagerProtocol
        
        resources.append(ApiResource(withHttpVerb: "GET", function: getListings, route: "/"))
        resources.append(ApiResource(withHttpVerb: "GET", function: getListing, route: "/{id}"))
        resources.append(ApiResource(withHttpVerb: "GET", function: getListingBaz, route: "/{id}/baz/{bazid}"))
    }
    
    func getListings(withWebRequest request: ApiRequest, response: ApiResponse) -> ApiResourceResponse {
        return ApiResourceResponse(withHttpStatus: HttpStatus.Ok, httpBody: "Showing All Listings")
    }
    
    func getListing(withWebRequest request: ApiRequest, response: ApiResponse) -> ApiResourceResponse {
        let id: Int = Int(request.webRequest.urlVariables["id"]!)!
        let listing = _listManagerProtocol.getListing(withId: id)
        return ApiResourceResponse(withHttpStatus: HttpStatus.Ok, httpBody: "Listings with Id: \(listing.id), Description:  \(listing.description)")
    }
    
    func getListingBaz(withWebRequest request: ApiRequest, response: ApiResponse) -> ApiResourceResponse {
        return ApiResourceResponse(withHttpStatus: HttpStatus.Ok, httpBody: "Listings with Id: \(request.webRequest.urlVariables["id"]!), BazId: \(request.webRequest.urlVariables["bazid"]!)")
    }
}















