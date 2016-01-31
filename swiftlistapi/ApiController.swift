//
//  ApiController.swift
//  api
//
//  Created by Todd Crown on 1/28/16.
//  Copyright © 2016 Todd Crown. All rights reserved.
//

import Foundation
import PerfectLib

protocol ApiControllerConfiguration {
    func baseResources() -> [AnyObject]
    func debugRoutes() -> Bool
}

extension ApiControllerConfiguration {
    func baseResources() -> [AnyObject] {
        let strMessage: String = "Add extension for ResourceConfiguration as follows:\n\n" +
        "extension ResourceConfiguration {\n" +
            "\tfunc baseResources() -> [AnyObject] {\n" +
                "\t\tvar resources: [AnyObject] = []\n" +
                "\t\tresources.append(MyController())\n" +
                "\t\treturn resources\n" +
            "\t}\n" +
        "}\n\n"
        
        fatalError(strMessage)
    }
    func debugRoutes() -> Bool {
        return false;
    }
}

struct ResourceConfiguration : ApiControllerConfiguration {
}


public func PerfectServerModuleInit() {
    
    // Install the built-in routing handler.
    // Using this system is optional and you could install your own system if desired.
    Routing.Handler.registerGlobally()

    let controller = ResourceConfiguration().baseResources()[0] as! ApiController
    for resource in controller.resources {
        Routing.Routes[resource.httpVerb, "\(controller.routePrefix)\(resource.route)"] = { _ in return controller}
    }
    
    
    //print out routes for debugging
    if(ResourceConfiguration().debugRoutes()) {
        print("\(Routing.Routes.description)")
    }
}

protocol ApiController : RequestHandler {
    var routePrefix: String { get set }
    var resources: [ApiResource] { get set }
}

extension ApiController {    
    func handleRequest(request: WebRequest, response: WebResponse) {
        
        var apiResourceResponse: ApiResourceResponse = ApiResourceResponse(withHttpStatus: HttpStatus.BadRequest, httpBody: "404: Not Found")
        
        for resource in resources {
            var foundAllParameters = true;
            if(resource.route != request.requestURI()) {
                for(param, _) in request.urlVariables {
                    if(!resource.route.contains("{\(param)}")) {
                        foundAllParameters = false;
                    }
                }
            }
            if(foundAllParameters) {
                let resourceFunc = resource.function as! (ApiRequest, ApiResponse) -> ApiResourceResponse
                apiResourceResponse = resourceFunc(ApiRequest(withWebRequest: request), ApiResponse(withWebResponse: response))
                break;
            }
        }
        
        response.setStatus(apiResourceResponse.httpStatus.rawValue, message: "\(apiResourceResponse.httpStatus)")
        response.appendBodyString(apiResourceResponse.httpBody);
        response.requestCompletedCallback();
    }
}

struct ApiRequest {
    let webRequest: WebRequest
    init(withWebRequest webRequest: WebRequest) {
        self.webRequest = webRequest
    }
}

struct ApiResponse {
    let webResponse: WebResponse
    init(withWebResponse webResponse: WebResponse) {
        self.webResponse = webResponse
    }
}

struct ApiResource {
    let httpVerb: String
    let route: String
    let function: Any

    init(withHttpVerb verb: String, function: Any, route: String ) {
        self.httpVerb = verb
        self.function = function
        self.route = route
    }
    
}

struct ApiResourceResponse {
    let httpStatus: HttpStatus
    let httpBody: String
    
    init(withHttpStatus httpStatus: HttpStatus, httpBody: String) {
        self.httpStatus = httpStatus
        self.httpBody = httpBody
    }
}

//top 10 status codes - more here: http://www.restapitutorial.com/httpstatuscodes.html
enum HttpStatus: Int {
    case Ok = 200
    case Created = 201
    case NoContent = 204
    case NotModified = 304
    case BadRequest = 400
    case Unauthorized = 401
    case Forbidden = 403
    case NotFound = 404
    case Conflict = 409
    case InternalServerError = 500
}











