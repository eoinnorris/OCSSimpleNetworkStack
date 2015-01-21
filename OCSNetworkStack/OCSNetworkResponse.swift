//
//  OCSNetworkResponse.swift
//  OCSNetworkStack
//
//  Created by Eoin Norris on 15/01/2015.
//  Copyright (c) 2015 Occassionaly Useful Software. All rights reserved.
//

import Cocoa

public struct OCSNetworkResponse{
    
    
    // internal data returned if any
    public var data:NSMutableData?
    var stream:NSOutputStream?

    // reponse of errors if any
    public var error:NSError? = nil
    public var internalResponse:NSHTTPURLResponse? = nil
    
    var isStreaming:Bool{
        get{
            return (stream != nil)
        }
    }
    
    init(error:NSError){
        self.error = error
    }
    
    init(stream:NSOutputStream){
        self.stream = stream
    }
    
    init(){
        self.data = NSMutableData();
    }
    
    public func appendData(inData:NSData){
        if isStreaming == false{
            self.data!.appendData(inData)
        } else {
            // add to open stream
        }
    }
}

