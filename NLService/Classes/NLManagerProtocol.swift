//
//  NLManagerProtocol.swift
//  Pods
//
//  Created by Juan Cruz Ghigliani on 29/8/16.
//
//

import Foundation

/** NLManagerProtocol protocol

*/
public enum NLMethod: String {
    case OPTIONS, GET, HEAD, POST, PUT, PATCH, DELETE, TRACE, CONNECT
}

public typealias CompleteBlock = (NSData?, NSError?)->Void

public protocol NLManagerProtocol {
    init(headers:[String:String]?)
    func cleanCookie()
    func setCookie(cookie:NSHTTPCookie)
    func request(method: NLMethod, _ URLString: String, parameters: [String: AnyObject]?, headers: [String: String]?, onCompleteBlock:CompleteBlock)
}
