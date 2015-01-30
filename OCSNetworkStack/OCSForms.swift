//
//  OCSForms.swift
//  OCSNetworkStack
//
//  Created by Eoin Norris on 15/01/2015.
//  Copyright (c) 2015 Occassionaly Useful Software. All rights reserved.
//

import Cocoa



public class OCSForms: OCSBody{
    
    
    public init(forms:Dictionary<String,String>){
        super.init(bodyStr: "")
        self.allForms = forms
        self.bodyType = .Forms
    }
    
    
    public override func validate()->ValidationError{
        return (false,nil)
    }
    
}
