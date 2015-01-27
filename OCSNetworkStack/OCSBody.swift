//
//  OCSBody.swift
//  OCSNetworkStack
//
//  Created by Eoin Norris on 15/01/2015.
//  Copyright (c) 2015 Occassionaly Useful Software. All rights reserved.
//

import Cocoa

public class OCSBody:OCSParam {
    
    init(bodyStr:String){
        super.init()
        self.bodyStr = bodyStr
        self.bodyType = .Body
    }
    
    // create body from dictionary
    // handle url encoding?
    
    public override func validate()->ValidationError{
        return (false,nil)
    }
    
    
}

