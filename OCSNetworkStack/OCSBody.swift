//
//  OCSBody.swift
//  OCSNetworkStack
//
//  Created by Eoin Norris on 15/01/2015.
//  Copyright (c) 2015 Occassionaly Useful Software. All rights reserved.
//

import Cocoa

public struct OCSBody {
    
    var body:String? = nil
    func validate()->ValidationError{
        return (body != nil, NSError());
    }
    
}

