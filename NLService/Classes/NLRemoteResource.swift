//
//  RemoteResource.swift
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

////////////////////////////////////////////////////////////////////////////////
// MARK: Types
public enum ResponseType {
    case JSON
    case Data
    case String
    case XML
}

public enum ParseResult<T> {
    case Success(T)
    case Error(NSError)
}

/**
 * Class to map an endpoint in a RemoteService
 */
public class NLRemoteResource<T> {

    public typealias parseResponseBlock = ( AnyObject ) -> ParseResult<T>

    ////////////////////////////////////////////////////////////////////////////////
    // MARK: Public Properties
    public var path:String = ""
    public var parser: parseResponseBlock?
    public var responseType: ResponseType = .JSON
    public var headers: [String: String]? = nil

    ////////////////////////////////////////////////////////////////////////////////
    // MARK: Setup & Teardown
    
    public init(_ path:String){
        self.path = path
    }
    
    ////////////////////////////////////////////////////////////////////////////////
    // MARK: public Methods
    
    func parseResponse(response:AnyObject) -> ParseResult<T>{
        if let block:parseResponseBlock = self.parser {
            return block(response);
        }
        return .Success(response as! T)
    }
    
}