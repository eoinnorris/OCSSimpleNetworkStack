//
//  OCSHeaders.swift
//  OCSNetworkStack
//
//  Created by Eoin Norris on 15/01/2015.
//  Copyright (c) 2015 Occassionaly Useful Software. All rights reserved.
//

import Cocoa


// crying out for a super class
public struct OCSHeaders:OCSParamProtocol {
    public var allHeaders:Dictionary<String,String>?
    public var allForms:Dictionary<String,String>?
    public var bodyType:BODYType = .Forms
    public var bodyStr:String?
    
    
    public init(){
        self.allHeaders = nil
    }
    
    public init(headers:Dictionary<String,String>){
        self.allHeaders = headers
    }
    
    
    public func validate()->ValidationError{
        return (allHeaders != nil,NSError());
    }
}
