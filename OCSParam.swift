//
//  OCSParam.swift
//  OCSNetworkStack
//
//  Created by Eoin Norris on 27/01/2015.
//  Copyright (c) 2015 Occassionaly Useful Software. All rights reserved.
//

import Cocoa

public class OCSParam:OCSParamProtocol {
    
    public var allHeaders:Dictionary<String,String>
    public var allForms:Dictionary<String,String>
    public var bodyType:BODYType
    public var bodyStr:String?
    
    
    public init(){
        self.bodyType = .None
        self.allHeaders = Dictionary<String,String>()
        self.allForms = Dictionary<String,String>()
    }
    
  
    public func validate()->ValidationError{
        return (false,nil)
    }
}
