//
//  OCSHeaders.swift
//  OCSNetworkStack
//
//  Created by Eoin Norris on 15/01/2015.
//  Copyright (c) 2015 Occassionaly Useful Software. All rights reserved.
//

import Cocoa

public struct OCSHeaders {
    var headers:[String:String]? = nil
    internal func validate()->ValidationError{
        return (headers != nil,NSError());
    }
    
    public init(headers:[String:String]!){
        self.headers = headers
    }
    
    public init (){
    }
}
