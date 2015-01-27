//
//  OCSBody.swift
//  OCSNetworkStack
//
//  Created by Eoin Norris on 15/01/2015.
//  Copyright (c) 2015 Occassionaly Useful Software. All rights reserved.
//

import Cocoa

/*
public protocol OCSParamProtocol{
    var allHeaders:Dictionary<String,String>? { get }
    var allForms:Dictionary<String,String>? { get }
    var bodyStr: String? { get }
    var bodyType:BODYType { get}
    func validate()->ValidationError
}

*/

public struct OCSBody:OCSParamProtocol {
    
    public var allHeaders:Dictionary<String,String>? = nil
    public var allForms:Dictionary<String,String>?? = nil
    public var bodyType:BODYType = .Body
    public var bodyStr:String?
    

    init(bodyStr:String){
        self.bodyStr = bodyStr
    }
    
    
    public func validate()->ValidationError{
        return ((self.bodyStr != nil), nil);
    }
    
    
}

