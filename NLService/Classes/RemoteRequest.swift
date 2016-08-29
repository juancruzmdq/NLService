//
//  RemoteRequest.swift
//
//Copyright (c) 2016 Juan Cruz Ghigliani <juancruzmdq@gmail.com> www.juancruzmdq.com.ar
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in
//all copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//THE SOFTWARE.

////////////////////////////////////////////////////////////////////////////////
// MARK: Imports
import Foundation
import Alamofire

public enum RemoteRequestResult<T> {
    case Success(T)
    case Error(NSError)
}


/**
 * Class that handle a request to a RemoteResource in a RemoteService
 */
public class RemoteRequest<T>{
    ////////////////////////////////////////////////////////////////////////////////
    // MARK: Types
    public typealias CompleteBlock = (RemoteRequestResult<T>)->Void

    ////////////////////////////////////////////////////////////////////////////////
    // MARK: Public Properties
    public var resource:RemoteResource<T>
    public var manager:Manager
    public var params:[String:String]
    public var HTTPMethod:Alamofire.Method = .GET
    public var service:RemoteService

    
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
    
    public func addParam(key:String,value:String) -> RemoteRequest<T>{
        self.params[key] = value
        return self
    }
    
    public func addParams(values:[String:String]) -> RemoteRequest<T>{
        for(k,v) in values{
            self.params[k] = v
        }
        return self
    }
    
    public func HTTPMethod(method:Alamofire.Method) -> RemoteRequest<T> {
        self.HTTPMethod = method
        return self
    }
        
    public func fullURLString() -> String{
        return self.fullURL().absoluteString
    }
    
    public func fullURL() -> NSURL{
        return self.service.baseURL.URLByAppendingPathComponent(self.resource.path)
    }

    /**
     Use manager to build the request to the remote service, and handle response
     
     - parameter onComplete: block to be call after handle response
     */
    public func load(onComplete:CompleteBlock){
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