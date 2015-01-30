//
//  OCSBody.swift
//  OCSNetworkStack
//
//  Created by Eoin Norris on 15/01/2015.
//  Copyright (c) 2015 Occassionaly Useful Software. All rights reserved.
//

import Cocoa

// "application/x-www-form-urlencoded"
public class OCSBody:OCSParam {

    public var length:Int{
        get {
            if let realStr = self.bodyStr{
                return countElements(realStr)
            }
            return 0
         }
    }
    
    public var encodedLength:Int{
        get {
                return countElements(self.encodedString)
            }
        }
    
    
    // convenience paramater for content_type
    public var encodedData:NSData{
        get {
            var encodedNSStr = self.encodedString as NSString
            return encodedNSStr.dataUsingEncoding(NSUTF8StringEncoding)!
        }
    }

    
    public var data:NSData?{
        get {
            if let realStr = self.bodyStr{
                var NSStr = realStr as NSString
                return NSStr.dataUsingEncoding(NSUTF8StringEncoding)!
            } else{
                return nil
            }
        }
    }
    
    public var encodedString:String{
        get {
            if let fullStr = self.bodyStr{
                return fullStr.urlEncode()
            } else{
                return ""
            }
        }
    }
    
    
    public override convenience init(){
        self.init(bodyStr:"")
    }
    
    public init(bodyStr:String){
        super.init()
        self.bodyStr = bodyStr
        self.bodyType = .Body
    }
    
    internal func parseHeaders()->String{
        return ""
    }
    
    
    public init(parts:Dictionary<String,String>){
        super.init()
        var bodyStr = ""
        for (key,value) in parts{
            bodyStr = bodyStr + "\(key)=\(value)&"
        }
        
        if (countElements(bodyStr) > 0){
            bodyStr.removeAtIndex(bodyStr.endIndex.predecessor())
            self.bodyStr = bodyStr
        }
    }
    // create body from dictionary
    // handle url encoding?
    
    
    
    public override func validate()->ValidationError{
        return (false,nil)
    }
    
    
}

