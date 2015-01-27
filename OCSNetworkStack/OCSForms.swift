//
//  OCSForms.swift
//  OCSNetworkStack
//
//  Created by Eoin Norris on 15/01/2015.
//  Copyright (c) 2015 Occassionaly Useful Software. All rights reserved.
//

import Cocoa



public struct OCSForms: OCSParamProtocol{
    
    public var allHeaders:Dictionary<String,String>? = nil
    public var allForms:Dictionary<String,String>?
    public var bodyType:BODYType = .Forms
    public var bodyStr:String?
    
    
    public init(){
        self.allForms = nil
    }
    
    public init(forms:Dictionary<String,String>){
        self.allForms = forms
    }
    
    
    public func validate()->ValidationError{
        return (allForms != nil,NSError());
    }
    
}
