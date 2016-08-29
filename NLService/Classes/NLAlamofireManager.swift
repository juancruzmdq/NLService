//
//  NLAlamofireManager.swift
//  Pods
//
//  Created by Juan Cruz Ghigliani on 29/8/16.
//
//

////////////////////////////////////////////////////////////////////////////////
// MARK: Imports
import Foundation
import Alamofire
////////////////////////////////////////////////////////////////////////////////
// MARK: Types


/**
 *  NLAlamofireManager Inherit NLManagerProtocol
 */
public class NLAlamofireManager:NLManagerProtocol {

    private var manager : Manager


    public required init(headers:[String:String]? = nil){
        // Create manager with custome header
        if headers != nil {
            self.manager = Alamofire.Manager(configuration: NLAlamofireManager.buildHeaders(headers!))
        }else{
            self.manager = Alamofire.Manager()
        }
    }
    
    public func cleanCookie(){
        if let storage = self.manager.session.configuration.HTTPCookieStorage{
            if let cookies = storage.cookies{
                for(cookie) in cookies{
                    storage.deleteCookie(cookie)
                }
            }
        }
    }
    
    public func setCookie(cookie:NSHTTPCookie){
        self.manager.session.configuration.HTTPCookieStorage?.setCookie(cookie)
    }
    
    public func request(method: NLMethod, _ URLString: String, parameters: [String: AnyObject]?, headers: [String: String]?, onCompleteBlock:CompleteBlock){
        self.manager
            .request(.GET, // TODO : Use NLMethod
                URLString,
                parameters: parameters,
                encoding:  .URL,
                headers: headers)
            .responseData{ (response) in
                onCompleteBlock(response.result.value, response.result.error)
        }
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

}
