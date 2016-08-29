//
//  Session.swift
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

/**
 * Class that handle and persist the session info
 */
public class NLSession : NSObject, NSCoding {
    ////////////////////////////////////////////////////////////////////////////////
    // MARK: Public Properties
    public var id: String

    ////////////////////////////////////////////////////////////////////////////////
    // MARK: Private Properties
    private var sessionData:Dictionary<String, AnyObject>
    
    /**
     Access session data with dictionary sintax ( session["key"] = .... )
     */
    subscript(key: String) -> AnyObject?
        {
        get
        {
            return sessionData[key]
        }
        set(newValue)
        {
            sessionData[key] = newValue
        }
    }
    
    ////////////////////////////////////////////////////////////////////////////////
    // MARK: Setup & Teardown
    public init(uniqueID:String){
        id = uniqueID
        sessionData = [:]
    }

    ////////////////////////////////////////////////////////////////////////////////
    // MARK: Class Methods
    static func restoreOrCreate(uniqueID:String) -> NLSession{
        let userDefaults = NSUserDefaults.standardUserDefaults()
        if let encodedObject:NSData = userDefaults.objectForKey(uniqueID) as? NSData{
            return (NSKeyedUnarchiver.unarchiveObjectWithData(encodedObject) as? NLSession)!
        }
        return NLSession(uniqueID: uniqueID)
    }

    ////////////////////////////////////////////////////////////////////////////////
    // MARK: NSCoder implementation

    public func encodeWithCoder(aCoder: NSCoder){
        aCoder.encodeObject(sessionData, forKey: "session_data")
        aCoder.encodeObject(id, forKey: "session_id")
    }
    
    convenience required public init?(coder aDecoder: NSCoder) {
        let sessionData = aDecoder.decodeObjectForKey("session_data")
        let id = aDecoder.decodeObjectForKey("session_id")
        
        self.init(uniqueID: id as! String)
        
        if (sessionData != nil){
            self.sessionData = sessionData as! Dictionary
        }
    }
    
    ////////////////////////////////////////////////////////////////////////////////
    // MARK: public Methods
    public func save(){
        let encodedObject:NSData = NSKeyedArchiver.archivedDataWithRootObject(self as AnyObject);
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setObject(encodedObject, forKey: self.id)
        userDefaults.synchronize()
    }
    
    public func delete(){
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.removeObjectForKey(self.id)
        userDefaults.synchronize()
    }
    
    public func clean() {
        self.sessionData = [:]
    }
    
    
}