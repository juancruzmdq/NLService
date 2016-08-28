//
//  RemoteService.swift
//
//  Created by Juan Cruz Ghigliani on 28/8/16.
//  Copyright © 2016 www.juancruzmdq.com.ar. All rights reserved.
//

////////////////////////////////////////////////////////////////////////////////
// MARK: Imports
import Foundation
import Alamofire

////////////////////////////////////////////////////////////////////////////////
// MARK: Types

/**
 * Wraper for a remote HTTP Service
 */
public class RemoteService {
    ////////////////////////////////////////////////////////////////////////////////
    // MARK: Private Properties
    private var manager : Manager
    
    ////////////////////////////////////////////////////////////////////////////////
    // MARK: Public Properties
    public var baseURL : NSURL
    public lazy var session: Session = { return Session.restoreOrCreate(self.sessionStoreKey()) }()

    
    ////////////////////////////////////////////////////////////////////////////////
    // MARK: Setup & Teardown
    public init(baseURL:NSURL,headers:[String:String]) {
        // Create manager with custome header
        self.manager = Alamofire.Manager(configuration: RemoteService.buildHeaders(headers))
        //store base url
        self.baseURL = baseURL
    }
    
    ////////////////////////////////////////////////////////////////////////////////
    // MARK: Class Methods
    
    /**
     Create a NSURLSessionConfiguration with the specified header values
     
     - parameter headers: Dictionary[String:String] with key:value heders values
     
     - returns: instance of the current NSURLSessionConfiguration
     */
    static func buildHeaders(headers:[String:String]) -> NSURLSessionConfiguration{
        // Concat header with default header
        var sharedHeaders = Alamofire.Manager.sharedInstance.session.configuration.HTTPAdditionalHeaders ?? [:]
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        
        for(k,v) in headers{
            sharedHeaders[k] = v
        }
        
        configuration.HTTPAdditionalHeaders = sharedHeaders
        
        return configuration
    
    }

    ////////////////////////////////////////////////////////////////////////////////
    // MARK: Session handle
    
    /**
     Unique session key for the current service
     
     - returns: String with the session Key value
     */
    private func sessionStoreKey() -> String{
        return "networking.remoteservice.session.\(baseURL.absoluteString)"
    }
    
    /**
     Restore or create the service Session instance 
     
     - parameter token: string with the token value
     
     - returns: Session instance
     */
    public func buildSession() -> Session{
        let session:Session = Session.restoreOrCreate(self.sessionStoreKey())
        session.clean()
        self.session = session
        return self.session
    }
    
    /**
     Remove current Session instance and creae a new empty session
     */
    public func cleanSession(){
        self.session.delete()
        self.session = self.buildSession()
        self.cleanCookie()

    }
    

    ////////////////////////////////////////////////////////////////////////////////
    // MARK: Cookies handle
 
    /**
     Remove cookies from the current manager
     */
    public func cleanCookie(){
        if let storage = manager.session.configuration.HTTPCookieStorage{
            if let cookies = storage.cookies{
                for(cookie) in cookies{
                    storage.deleteCookie(cookie)
                }
            }
        }
    }
    
    /**
     Add a new set of cookies to the current manager
     
     - parameter cookie: instance of NSHTTPCookie
     */
    public func setCookie(cookie:NSHTTPCookie){
        manager.session.configuration.HTTPCookieStorage?.setCookie(cookie)
    }

    ////////////////////////////////////////////////////////////////////////////////
    // MARK: Request Factory
    
    /**
     Build a RemoteRequest for a RemoteResource
     
     - parameter resource: RemoteResource instance
     
     - returns: RemoteRequest instance
     */
    public func request<T>(resource:RemoteResource<T>) -> RemoteRequest<T>{
        return (self.request(resource,manager: self.manager))
    }

    /**
     Build a RemoteRequest for a RemoteResource, and specify with network manager should use the request
     
     - parameter resource: RemoteResource instance
     - parameter manager:  Alamofire.Manager instance
     
     - returns: RemoteRequest instance
     */
    private func request<T>(resource:RemoteResource<T>,manager:Manager) -> RemoteRequest<T>{
        if resource.responseType == .XML {
            return RemoteXMLRequest<T>(resource: resource,service: self,manager: manager)
        }else{
            return RemoteJSONRequest<T>(resource: resource,service: self,manager: manager)
        }
        // TODO : Implement .Data and .String

    }

}



