//
//  Session.swift
//
//  Created by Juan Cruz Ghigliani on 28/8/16.
//  Copyright © 2016 www.juancruzmdq.com.ar. All rights reserved.
//


////////////////////////////////////////////////////////////////////////////////
// MARK: Imports
import Foundation

/**
 * Class that handle and persist the session info
 */
public class Session : NSObject, NSCoding {
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
    static func restoreOrCreate(uniqueID:String) -> Session{
        let userDefaults = NSUserDefaults.standardUserDefaults()
        if let encodedObject:NSData = userDefaults.objectForKey(uniqueID) as? NSData{
            return (NSKeyedUnarchiver.unarchiveObjectWithData(encodedObject) as? Session)!
        }
        return Session(uniqueID: uniqueID)
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