//
//  OCSHeaders.swift
//  OCSNetworkStack
//
//  Created by Eoin Norris on 15/01/2015.
//  Copyright (c) 2015 Occassionaly Useful Software. All rights reserved.
//

import Cocoa

public var globalHeaders:Dictionary<String,String> = Dictionary<String,String>()



// crying out for a super class
public class OCSHeaders:OCSParam {
    
  //  public var bodyType:BODYType = .Headers


    public override init(){
        super.init()
        self.bodyType = .Headers

    }
    
    // MARK:-- Convenience settings
    public func setUserAgent(useragent:String)->Void{
        self.allHeaders["User-Agent"] = useragent
    }
    
    public func setContentType(contentType:String)->Void{
        self.allHeaders["Content-Type"] = contentType

    }
    
    public func setAcceptEncoding(acceptEncoding:String)->Void{
        self.allHeaders["Accept-Encoding"] = acceptEncoding
    }
    
    public func setAuthorization(authStr:String)->Void{
        self.allHeaders["Authorization"] = authStr
    }
    
    // MARK: -- Convenience class settings

    
    public class func setAuthorization(authStr:String)->Void{
        globalHeaders["Authorization"] = authStr
    }
    
    public class func setAcceptEncoding(acceptEncoding:String)->Void{
        globalHeaders["Accept-Encoding"] = acceptEncoding
    }
    
    public class func setContentType(contentType:String)->Void{
        globalHeaders["Content-Type"] = contentType
    }
    
    public class func setUserAgent(useragent:String)->Void{
        globalHeaders["User-Agent"] = useragent
    }
    
    
    public init(headers:Dictionary<String,String>){
        super.init()
        
        self.bodyType = .Headers
        
        if (globalHeaders.count > 0){
            self.allHeaders = globalHeaders
        }
        
        for (key,value) in headers{
            self.allHeaders[key] = value
        }
    }
    
    
    
    public override func validate()->ValidationError{
     
        return (false,nil)
    }
    
}
