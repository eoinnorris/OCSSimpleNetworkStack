//
//  OCSSimpleNetworkInterface.swift
//  OCSNetworkStack
//
//  Created by Eoin Norris on 14/01/2015.
//  Copyright (c) 2015 Occassionaly Useful Software. All rights reserved.
//

import Cocoa


public typealias ValidationError = (isError:Bool,error:NSError?)


internal class OCSSimpleNetworkInterfaceHelper{
    var settings:OCSHttpSettings?
    
    internal func addHeadersOrBody(){
        
    }
}

public class OCSHttp: NSObject,NSURLConnectionDataDelegate{
    
    public override init(){
        self.response = OCSHttpResponse()
        self.settings = OCSHttpSettings()
        super.init();
    }
    
    var settings:OCSHttpSettings
    var response:OCSHttpResponse
    var responsefunc:((OCSHttpResponse!) -> Void)?
    var helper:OCSSimpleNetworkInterfaceHelper = OCSSimpleNetworkInterfaceHelper()

    // NSURLConnectionDownloadDelegate handling
    
   
    public func connection(connection: NSURLConnection, didReceiveData data: NSData){
        response.appendData(data)
    }
    
    public func connectionDidFinishLoading(connection: NSURLConnection){
        NSLog("connectionDidFinishLoading")
        responsefunc!(self.response)
    }
    
    
    public func connection(connection: NSURLConnection, didFailWithError error: NSError){
        self.response.error = error;
        responsefunc!(self.response)
    }
    
    public func connection(connection: NSURLConnection, didReceiveResponse response: NSURLResponse){
        self.response.internalResponse = response as? NSHTTPURLResponse
    }

    internal func populateResponseWithBadSettings(response: (OCSHttpResponse!) -> Void, error:NSError){
        var inValidSettingsError = NSError()
        response(OCSHttpResponse(error: inValidSettingsError));
    }
    
    internal func validateSettings(settings:OCSHttpSettings, response: (OCSHttpResponse!) -> Void)->ValidationError{
        var validSettings:ValidationError = settings.validate()
    
        if let error = validSettings.error{
            populateResponseWithBadSettings(response,error: error)
        }
        
        return validSettings
    }
    
    public func sendAsyncRequest(path:String, responseFunc: (OCSHttpResponse!) -> Void) -> Void{
        self.sendAsyncRequest(OCSHttpSettings(path: path), responseFunc: responseFunc);
        return;
    }
    
    public func sendAsyncRequest(settings:OCSHttpSettings, responseFunc: (OCSHttpResponse!) -> Void) -> Void{
        var validSettings = validateSettings(settings, responseFunc)
        if validSettings.isError == false{
            self.settings = settings
            self.responsefunc = responseFunc
            self.settings.internalRequest.methodType = self.settings.method
            if let request = self.settings.internalRequest.urlRequest{
                if let allHeaders = request.allHTTPHeaderFields{
                    for (key,value) in allHeaders{
                        NSLog("key is \(key) value is \(value)")
                    }
                }
                
                var conn = NSURLConnection(request: request, delegate: self)
            }
        }
    
        return;
    }

    
    

}
