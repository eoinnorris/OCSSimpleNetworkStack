//
//  OCSNetworkSettings.swift
//  OCSNetworkStack
//
//  Created by Eoin Norris on 15/01/2015.
//  Copyright (c) 2015 Occassionaly Useful Software. All rights reserved.
//

import Cocoa

var OCSURLRequestGlobalTimeout = 60.0
var OCSURLRequestGlobalCache:NSURLRequestCachePolicy  = .ReloadIgnoringLocalCacheData


public struct OCSURLRequest{
    
    var request:NSURLRequest{
        get{
            return NSURLRequest(URL: self.url, cachePolicy: self.cacheType, timeoutInterval: self.timeout)
        }
    }
    
    var cacheType:NSURLRequestCachePolicy = OCSURLRequestGlobalCache
    var url:NSURL = NSURL()
    var timeout:NSTimeInterval = OCSURLRequestGlobalTimeout
    
    public static func setGlobalTimeout(timeout:Double){
        OCSURLRequestGlobalTimeout = timeout
    }
    
    public static func setGlobalCache(cache:NSURLRequestCachePolicy){
        OCSURLRequestGlobalCache = cache
    }
    
    init(url:NSURL){
        self.url = url;
    }
    
    init(){
        
    }
}




public struct OCSNetworkSettings {
    /// The kind of HTTP request. Get is default
    enum Method {
        case GET
        case POST
        case DELETE
    }
    
    // what kind of body if any. None is default
    enum BODYType{
        case Headers
        case Forms
        case Body
        case None
    }
    
    // what kind of deserialisation should be performed on the raw data
    //
    enum DeSerialisationType{
        case JSON
        case STRING
        case PLIST
        case CUSTOM
        case NONE
    }
    
    
    // forms
    var body = OCSBody()
    var forms = OCSForms()
    var headers = OCSHeaders()
    var requestType:OCSURLRequest = OCSURLRequest()
    var deSerialisationType:DeSerialisationType = .NONE
    
    // a stream based API should read the data from the stream first.
    
    var deSerialisationFunc:((rawData:NSData!) -> AnyObject)?{
        didSet{
            deSerialisationType = .CUSTOM
        }
    }
    
    var url: NSURL = NSURL()

    var method: Method = .GET
    var bodytype:BODYType = .None
    var session: OCSSession = OCSSession()
    var responseType:OCSResponseType = OCSResponseType()
    
    var willQueue:Bool = false
    
    
    // path and methods
    
    public init?(path:String){
        var possibleURL = NSURL(string: path)
        if let thisURL = possibleURL{
            self.url = thisURL
            self.requestType = OCSURLRequest(url: self.url);
        } else {
            NSLog("The path /(path) could not be co-erced into a url")
            return nil
        }
    }
    
    
    public init(){
        
    }
    
    public init(url:NSURL){
        self.url = url
        self.requestType = OCSURLRequest(url: url);
    }
    
    // convenience inits for BodyTypes:
    
    public init(url:NSURL,body:OCSBody){
        self.url = url
        self.bodytype = .Body;
        self.body = body
        self.requestType = OCSURLRequest(url: url);
    }
    
    public init(url:NSURL,forms:OCSForms){
        self.url = url
        self.bodytype = .Forms
        self.forms = forms
        self.requestType = OCSURLRequest(url: url);
    }
    
    public init(url:NSURL,headers:OCSHeaders){
        self.url = url
        self.bodytype = .Headers
        self.headers = headers
        self.requestType = OCSURLRequest(url: url);
    }
    
    
    internal func validateBodyTypes()->ValidationError{
        var valid:ValidationError = (false,nil);
        
        switch bodytype{
        case .Headers:
            valid = headers.validate()
        case .Forms:
            valid = body.validate()
        case .Headers:
            valid = headers.validate()
        case .None:
            valid = (false,nil);

        default:
            valid = (false,nil);
        }
        
        
        return valid
    }
    
    internal func validateDeSerialisation()->ValidationError{
        var valid:ValidationError = (false,nil);
        
        switch deSerialisationType{
            // If the type is custom then there has to be be a user function.
            // generally this would be set automatically but its possible for the user to ignore.
            case .CUSTOM:
                if let deSerialisationFunc =  self.deSerialisationFunc{
                    valid = (false,nil);
                } else {
                    
                    // to do a proper error generating class
                    var error = NSError(domain: "com.ocs.settings.validation", code: 4001, userInfo: ["BadSetting":"Missing custom deserialiser"])
                }
            
            // all other cases will have a default internal function
            default:
                valid = (false,nil);
        }
        
        
        return valid
    }
    
    
    internal func validate()->ValidationError{
        
        // to do - validate URL exists
        
        var valid:ValidationError = self.validateBodyTypes();
        
        if valid.isError == false{
            valid = self.validateDeSerialisation()
        }
        
        return valid
    }
}
