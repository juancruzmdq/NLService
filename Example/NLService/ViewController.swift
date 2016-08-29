//
//  ViewController.swift
//  NLService
//
//  Created by Juan Cruz Ghigliani on 08/28/2016.
//  Copyright (c) 2016 Juan Cruz Ghigliani. All rights reserved.
//

import UIKit
import NLService

class ViewController: UIViewController {

    lazy var api:RemoteService = {
        let service = RemoteService(baseURL: NSURL(string: "https://api.github.com")!,
                                    manager: NLAlamofireManager(headers: ["Header-Global":"value global"]))
        return service
        }()
    
    lazy var repoInfo:RemoteResource<String> = {
        var res = RemoteResource<String>("/repos/juancruzmdq/NLService")
        res.headers = ["Header-Repo":"value for repo"]
        res.parser = {( result )->ParseResult<String> in
            guard let info = result as? NSDictionary else{
                return .Error(NSError(domain: "ViewController", code: 0, localizedDescription: "Invalid response???"))
            }
            return .Success("\(info["id"]!) - \(info["name"]!)")
        }
        return res
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let service = RemoteService(baseURL: NSURL(string: "https://api.github.com")!, manager:NLAlamofireManager())
        let resource = RemoteResource<NSDictionary>("/repos/juancruzmdq/NLService")
        service.request(resource).load { (dict) in
            switch dict {
            case .Success(let dict):
                print("API Result: \(dict)")
                break
            case .Error(let error):
                print("API Error: \(error.localizedDescription)")
                break
            }
        }
        
            
        // Do any additional setup after loading the view, typically from a nib.
        api.request(repoInfo).load { (result) in
            switch result {
            case .Success(let string):
                print("API Result: \(string)")
                break
            case .Error(let error):
                print("API Error: \(error.localizedDescription)")
                break
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

