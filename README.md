# NLService

[![CI Status](http://img.shields.io/travis/Juan Cruz Ghigliani/NLService.svg?style=flat)](https://travis-ci.org/Juan Cruz Ghigliani/NLService)
[![Version](https://img.shields.io/cocoapods/v/NLService.svg?style=flat)](http://cocoapods.org/pods/NLService)
[![License](https://img.shields.io/cocoapods/l/NLService.svg?style=flat)](http://cocoapods.org/pods/NLService)
[![Platform](https://img.shields.io/cocoapods/p/NLService.svg?style=flat)](http://cocoapods.org/pods/NLService)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

NLService is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "NLService"
```
## Example

```ruby

The simplest example

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

```

```ruby

// Build Main Service
let service = RemoteService(baseURL: NSURL(string: "https://api.github.com")!, manager: NLAlamofireManager(headers: ["Header-Global":"value global"])) // optional global headers

// Build resource endpoint with parser
let repoInfo = RemoteResource<String>("/repos/juancruzmdq/NLService")
repoInfo.headers = ["Header-Repo":"value for repo"]
repoInfo.parser =  = {( result )->ParseResult<String> in
    guard let info = result as? NSDictionary else{
        return .Error(NSError(domain: "ViewController", code: 0, localizedDescription: "Invalid response???"))
    }
    return .Success("\(info["id"]!) - \(info["name"]!)")
}


// Use service to create request to resource, and perform call (load) of the remote resource
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


```


## Author

Juan Cruz Ghigliani, juancruzmdq@gmail.com

## License

NLService is available under the MIT license. See the LICENSE file for more info.
