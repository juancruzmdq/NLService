//
//  RemoteJSONRequest.swift
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
                parameters: self.params)
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
