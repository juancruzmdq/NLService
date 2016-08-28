//
//  RemoteRequest.swift
//
//  Created by Juan Cruz Ghigliani on 28/8/16.
//  Copyright © 2016 www.juancruzmdq.com.ar. All rights reserved.
//

////////////////////////////////////////////////////////////////////////////////
// MARK: Imports
import Foundation
import Alamofire

enum RemoteRequestResult<T> {
    case Success(T)
    case Error(NSError)
}


/**
 * Class that handle a request to a RemoteResource in a RemoteService
 */
class RemoteRequest<T>{
    ////////////////////////////////////////////////////////////////////////////////
    // MARK: Types
    typealias CompleteBlock = (RemoteRequestResult<T>)->Void

    ////////////////////////////////////////////////////////////////////////////////
    // MARK: Public Properties
    var resource:RemoteResource<T>
    var manager:Manager
    var params:[String:String]
    var HTTPMethod:Alamofire.Method = .GET
    var service:RemoteService

    
    ////////////////////////////////////////////////////////////////////////////////
    // MARK: Setup & Teardown
    internal init(resource:RemoteResource<T>, service:RemoteService, manager:Manager){
        self.service = service
        self.resource = resource
        self.manager = manager
        self.params = [:]
    }
    
    ////////////////////////////////////////////////////////////////////////////////
    // MARK: public Methods
    
    func addParam(key:String,value:String) -> RemoteRequest<T>{
        self.params[key] = value
        return self
    }
    
    func addParams(values:[String:String]) -> RemoteRequest<T>{
        for(k,v) in values{
            self.params[k] = v
        }
        return self
    }
    
    func HTTPMethod(method:Alamofire.Method) -> RemoteRequest<T> {
        self.HTTPMethod = method
        return self
    }
        
    func fullURLString() -> String{
        return self.fullURL().absoluteString
    }
    
    func fullURL() -> NSURL{
        return self.service.baseURL.URLByAppendingPathComponent(self.resource.path)
    }

    /**
     Use manager to build the request to the remote service, and handle response
     
     - parameter onComplete: block to be call after handle response
     */
    func load(onComplete:CompleteBlock){
         preconditionFailure("This method must be overridden - HEEEEELPPPPPPPPP I DON'T KNOW WHAT TO DO")
    }

    func handleError(error:NSError?,onComplete:CompleteBlock){
        if let error:NSError = error{
            onComplete(.Error(error))
        }else{
            onComplete(.Error(NSError(domain: "RemoteService", code: 5003, localizedDescription:"Empty Response")))
        }
    }
}