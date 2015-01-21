//
//  OCSForms.swift
//  OCSNetworkStack
//
//  Created by Eoin Norris on 15/01/2015.
//  Copyright (c) 2015 Occassionaly Useful Software. All rights reserved.
//

import Cocoa

public struct OCSForms {
    var forms:Dictionary<String,Int>? = nil
    
    internal func validate()->ValidationError{
        return (forms != nil,NSError());
    }
    
}
