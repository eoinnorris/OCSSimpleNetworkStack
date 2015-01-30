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

// what kind of body if any. None is default
public enum BODYType{
    case Headers
    case Forms
    case Body
    case None
}

public enum Method:String {
    case GET = "GET"
    case POST = "POST"
    case DELETE = "DELETE"
}


public protocol OCSParamProtocol{
    var allHeaders:Dictionary<String,String> { get }
    var allForms:Dictionary<String,String> { get }
    var bodyStr: String? { get }
    var bodyType:BODYType { get}
    func validate()->ValidationError
}


public struct OCSURLRequest{
    
    var urlRequest:NSMutableURLRequest?
    
    internal func setRequestMethod(method:Method){
        var methodStr = method.rawValue
        self.urlRequest!.HTTPMethod = methodStr
    }
    
    internal func setRequestHeaders(headers:OCSHeaders){
        for (key,value) in headers.allHeaders{
            self.urlRequest!.setValue(value as NSString, forHTTPHeaderField:key  as NSString)
        }
    }
    
    internal func setRequestBody(body:OCSBody){
        self.urlRequest!.HTTPBody = body.data
    }
    
    
    var param:OCSBody?
    var headers:OCSHeaders?
    var methodType:Method = .GET{
        didSet{
            var methodStr = methodType.rawValue
            self.urlRequest!.HTTPMethod = methodStr
        }
    }
    
    var cacheType:NSURLRequestCachePolicy = OCSURLRequestGlobalCache
    var url:NSURL? = NSURL()
    var timeout:NSTimeInterval = OCSURLRequestGlobalTimeout
    
    public static func setGlobalTimeout(timeout:Double){
        OCSURLRequestGlobalTimeout = timeout
    }
    
    public static func setGlobalCache(cache:NSURLRequestCachePolicy){
        OCSURLRequestGlobalCache = cache
    }
    
    public func validateTypes()->ValidationError{
        if let realParam = self.param{
            return realParam.validate()
        } else {
            return (false,nil)
        }
    }
    
    internal func setUpRequest(){
        if (self.methodType != .GET){
            self.setRequestMethod(self.methodType)
        }
        if let realBody = self.param{
            self.setRequestBody(realBody)
        }
        if let realHeaders = self.headers{
            self.setRequestHeaders(realHeaders)
        }
        
        
    }
    
    init(url:NSURL, body:OCSBody? = nil, headers:OCSHeaders? = nil){
        self.url = url;
        self.param = body
        self.headers = headers
        self.urlRequest = NSMutableURLRequest(URL: self.url!, cachePolicy: self.cacheType, timeoutInterval: self.timeout)
        var (_,isError) = self.validateTypes()
        if isError == nil{
   
            self.setUpRequest()
        } else {
            // callback?
        }
    }
    
    init(){
        self.urlRequest = nil
    }
}

public struct OCSRequestParam{
    
    var param:OCSParamProtocol?
    var methodType:String = "GET"
    
    
    var allHeaders:Dictionary<String,String>?  {
        get{
            return param!.allHeaders
        }
    }
    
    var allForms:Dictionary<String,String>? {
        get {
            return param!.allForms
        }
    }

    var bodyStr: String? {
        get{
            return param!.bodyStr
        }
    }
    
    var bodyType:BODYType {
        get{
            if let realParam = param{
                return realParam.bodyType
            } else{
                return .None
            }
        }
    }
    
    init(requestParam:OCSParamProtocol){
        self.param = requestParam
    }
    
    init(){
        
    }
    
    func validate()->ValidationError{
        if let realParam = self.param{
            return realParam.validate()
        } else {
            return (false,nil)
        }
    }
    
    
}


public struct OCSHttpSettings {
    /// The kind of HTTP request. Get is default

    
    
    // what kind of deserialisation should be performed on the raw data
    //
    enum DeSerialisationType{
        case JSON
        case STRING
        case PLIST
        case CUSTOM
        case NONE
    }
    
    let errorGenerator = OCSErrorGenerator()
    
    // forms
    // private - only settable in the init
    var internalRequest:OCSURLRequest = OCSURLRequest()
    var deSerialisationType:DeSerialisationType = .NONE
    
    // a stream based API should read the data from the stream first.
    
    var deSerialisationFunc:((rawData:NSData!) -> AnyObject)?{
        didSet{
            deSerialisationType = .CUSTOM
        }
    }
    
    var url: NSURL = NSURL()

    public var method: Method = .GET{
        didSet{
            self.internalRequest.methodType = method
        }
    }
    var bodytype:BODYType = .None
    var responseType:OCSResponseType = OCSResponseType()
    
    var willQueue:Bool = false
    
    public func setAcceptableContentTypes([String])->Bool{
        return true
    }
    
    // MARK: -- initializations
    
    // path and methods
    
    public init(path:String){
        var possibleURL = NSURL(string: path)
        if let thisURL = possibleURL{
            self.url = thisURL
            self.internalRequest = OCSURLRequest(url: self.url , body: nil);
        }
    }
    
    
    public init(){
        
    }
    
    public init(url:NSURL){
        self.url = url
        self.internalRequest = OCSURLRequest(url: self.url)
    }
    
    // convenience inits for BodyTypes:
    // change to path
    public init(url:NSURL,body:OCSBody){
        self.url = url
        self.internalRequest = OCSURLRequest(url: url, body:body);
    }
    
    public init(url:NSURL,forms:OCSForms){
        self.url = url
        self.internalRequest = OCSURLRequest(url: url, body:forms);
    }
    
    
    internal func createHeadersFromBodyIfHeadersMissing(body:OCSBody?)->OCSHeaders?{
        var result:OCSHeaders? = nil
        if let realBody = body{
            result =  OCSHeaders(contentLength: realBody.length);
        }
        return result
    }
    
    
    public init(url:NSURL,var headers:OCSHeaders? = nil,body:OCSBody? = nil){
        if headers == nil {
           headers = self.createHeadersFromBodyIfHeadersMissing(body)
        }
        self.url = url
        self.internalRequest = OCSURLRequest(url: url, body:body, headers:headers);
        
    }
    
    // MARK: -- validation
    internal func validateBodyTypes()->ValidationError{
        return self.internalRequest.validateTypes()
    }
    
    internal func validateDeSerialisationTypes()->ValidationError{
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
    
    internal func validateURL()->ValidationError{
        var hasError:ValidationError  = (false,nil)
        if let validURL = self.internalRequest.url{
            hasError = (false,nil);
        } else {
            var error = NSError(domain: "com.ocs.settings.validation", code: 4002, userInfo: ["Bad Internal Setting":"Missing URL"])
            hasError = (true,error);
        }
        
        return hasError;
    }
    
    internal func validate()->ValidationError{
        
        // to do - validate URL exists
        var valid:ValidationError = self.validateURL()
        
        if valid.isError == false{
            valid = self.validateBodyTypes();
        }
        
        if valid.isError == false{
            valid = self.validateDeSerialisationTypes()
        }
        
        return valid
    }
}
