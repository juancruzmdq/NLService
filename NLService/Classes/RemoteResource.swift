//
//  RemoteResource.swift
//
//  Created by Juan Cruz Ghigliani on 28/8/16.
//  Copyright © 2016 www.juancruzmdq.com.ar. All rights reserved.
//

////////////////////////////////////////////////////////////////////////////////
// MARK: Imports
import Foundation

////////////////////////////////////////////////////////////////////////////////
// MARK: Types
public enum ResponseType {
    case JSON
    case Data
    case String
    case XML
}

enum ParseResult<T> {
    case Success(T)
    case Error(NSError)
}

/**
 * Class to map an endpoint in a RemoteService
 */
class RemoteResource<T> {

    typealias parseResponseBlock = ( AnyObject ) -> ParseResult<T>

    ////////////////////////////////////////////////////////////////////////////////
    // MARK: Public Properties
    var path:String = ""
    var parser: parseResponseBlock?
    var responseType: ResponseType = .JSON

    ////////////////////////////////////////////////////////////////////////////////
    // MARK: Setup & Teardown
    
    internal init(_ path:String){
        self.path = path
    }
    
    ////////////////////////////////////////////////////////////////////////////////
    // MARK: public Methods
    
    func parseResponse(response:AnyObject) -> ParseResult<T>{
        if let block:parseResponseBlock = self.parser {
            return block(response);
        }
        return .Error(NSError(domain: "RemoteResource", code: 0, localizedDescription: "Empty Parser"))
    }
    
}