//
//  NSError+Custom.swift
//
//  Created by Juan Cruz Ghigliani on 28/8/16.
//  Copyright © 2016 www.juancruzmdq.com.ar. All rights reserved.
//

import Foundation

/** Custom Extends NSError

*/
extension NSError {
    public convenience init(domain:String,
                            code:Int,
                            localizedDescription:String,
                            localizedFailureReasonError:String = "",
                            localizedRecoverySuggestionError:String = ""
                            ) {
        self.init(domain: domain, code: code, userInfo: [
            NSLocalizedDescriptionKey: localizedDescription,
            NSLocalizedFailureReasonErrorKey: localizedFailureReasonError,
            NSLocalizedRecoverySuggestionErrorKey: localizedRecoverySuggestionError
            ]
        )
    }
}
