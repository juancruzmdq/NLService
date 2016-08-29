//
//  RemoteJSONRequest.swift
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

////////////////////////////////////////////////////////////////////////////////
// MARK: Types

/**
 *  RemoteJSONRequest Inherit RemoteRequest
 */
public class RemoteJSONRequest<T>:RemoteRequest<T> {

    ////////////////////////////////////////////////////////////////////////////////
    // MARK: Private Properties

    ////////////////////////////////////////////////////////////////////////////////
    // MARK: Public Properties

    ////////////////////////////////////////////////////////////////////////////////
    // MARK: IBOutlets

    ////////////////////////////////////////////////////////////////////////////////
    // MARK: Setup & Teardown
    public override init(resource:RemoteResource<T>, service:RemoteService, manager:Manager){
        super.init(resource: resource, service: service, manager: manager)
    }

    ////////////////////////////////////////////////////////////////////////////////
    // MARK: Class Methods

    ////////////////////////////////////////////////////////////////////////////////
    // MARK: Override Methods
    public override func load(onComplete:CompleteBlock){
        self.manager
            .request(self.HTTPMethod,
                self.fullURLString(),
                parameters: self.params,
                encoding:  .URL,
                headers: self.resource.headers)
            .responseJSON { (response) in
                if let JSON = response.result.value {
                    
                    let result = self.resource.parseResponse(JSON)
                    switch result {
                    case .Success(let result):
                        onComplete(.Success(result))
                        break
                    case .Error(let error):
                        onComplete(.Error(error))
                        break
                    }
                }else{
                    self.handleError(response.result.error,onComplete:onComplete)
                }
        }
    }
    
    ////////////////////////////////////////////////////////////////////////////////
    // MARK: Private Methods

    ////////////////////////////////////////////////////////////////////////////////
    // MARK: public Methods


}
