//
//  RemoteXMLRequest.swift
//
//  Created by Juan Cruz Ghigliani on 28/8/16.
//  Copyright © 2016 www.juancruzmdq.com.ar. All rights reserved.
//

////////////////////////////////////////////////////////////////////////////////
// MARK: Imports
import Foundation
import Ono
import Alamofire

////////////////////////////////////////////////////////////////////////////////
// MARK: Types

/**
 *  RemoteXMLRequest Inherit RemoteRequest
 */
public class RemoteXMLRequest<T>:RemoteRequest<T> {

    ////////////////////////////////////////////////////////////////////////////////
    // MARK: Private Properties

    ////////////////////////////////////////////////////////////////////////////////
    // MARK: Public Properties

    ////////////////////////////////////////////////////////////////////////////////
    // MARK: IBOutlets

    ////////////////////////////////////////////////////////////////////////////////
    // MARK: Setup & Teardown
    override public init(resource:RemoteResource<T>, service:RemoteService, manager:Manager){
        super.init(resource: resource, service: service, manager: manager)
    }

    ////////////////////////////////////////////////////////////////////////////////
    // MARK: Class Methods

    ////////////////////////////////////////////////////////////////////////////////
    // MARK: Override Methods
    override public func load(onComplete:CompleteBlock){
        self.manager
            .request(self.HTTPMethod,
                self.fullURLString(),
                parameters: self.params)
            .responseData{ (response) in
                if let data = response.data {
                    do{
                        let XML:ONOXMLDocument = try ONOXMLDocument(data: data)
                        
                        let result = self.resource.parseResponse(XML)
                        
                        switch result {
                        case .Success(let result):
                            onComplete(.Success(result))
                            break
                        case .Error(let error):
                            onComplete(.Error(error))
                            break
                        }
                        
                    }catch{
                        onComplete(.Error(NSError(domain: "RemoteService", code: 5002, localizedDescription:"Parsing Response to XML")))
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
