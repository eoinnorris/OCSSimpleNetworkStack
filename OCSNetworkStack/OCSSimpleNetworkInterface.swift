//
//  OCSSimpleNetworkInterface.swift
//  OCSNetworkStack
//
//  Created by Eoin Norris on 14/01/2015.
//  Copyright (c) 2015 Occassionaly Useful Software. All rights reserved.
//

import Cocoa


typealias ValidationError = (isError:Bool,error:NSError?)


internal class OCSSimpleNetworkInterfaceHelper{
    var settings:OCSNetworkSettings?
    
    internal func addHeadersOrBody(){
        
    }
    
    
}

public class OCSSimpleNetworkInterface: NSObject,NSURLConnectionDataDelegate{
    
    public override init(){
        self.response = OCSNetworkResponse()
        self.settings = OCSNetworkSettings()
        super.init();
    }
    
    var settings:OCSNetworkSettings
    var response:OCSNetworkResponse
    var responsefunc:((OCSNetworkResponse!) -> Void)?
    var helper:OCSSimpleNetworkInterfaceHelper = OCSSimpleNetworkInterfaceHelper()

    // NSURLConnectionDownloadDelegate handling
    
   
    public func connection(connection: NSURLConnection, didReceiveData data: NSData){
        response.appendData(data)
    }
    
    public func connectionDidFinishLoading(connection: NSURLConnection){
        NSLog("connectionDidFinishLoading")
        responsefunc!(self.response)
    }
    
//    public func connectionDidFinishDownloading(connection: NSURLConnection, destinationURL: NSURL){
//        responsefunc!(self.response)
//    }
    
    public func connection(connection: NSURLConnection, didFailWithError error: NSError){
        self.response.error = error;
        responsefunc!(self.response)
    }
    
    public func connection(connection: NSURLConnection, didReceiveResponse response: NSURLResponse){
        self.response.internalResponse = response as? NSHTTPURLResponse
    }

    internal func populateResponseWithBadSettings(response: (OCSNetworkResponse!) -> Void, error:NSError){
        var inValidSettingsError = NSError()
        response(OCSNetworkResponse(error: inValidSettingsError));
    }
    
    internal func validateSettings(response: (OCSNetworkResponse!) -> Void)->ValidationError{
        var validSettings:ValidationError = settings.validate()
    
        if let error = validSettings.error{
            populateResponseWithBadSettings(response,error: error)
        }
        
        return validSettings
    }
    
    
    public func sendAsyncRequest(settings:OCSNetworkSettings, responseFunc: (OCSNetworkResponse!) -> Void) -> NSOperation?{
        
        self.settings = settings
        self.helper.settings = settings;

        var validSettings = validateSettings(responseFunc)
        if validSettings.isError == false{
            self.responsefunc = responseFunc
            var url = self.settings.url
            var request = self.settings.requestType.request
            var conn = NSURLConnection(request: request, delegate: self)
        }
    
        return (self.settings.willQueue) ? NSOperation() :  nil
    }

    
    

}
