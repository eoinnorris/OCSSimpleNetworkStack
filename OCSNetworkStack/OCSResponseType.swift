//
//  OCSResponseType.swift
//  OCSNetworkStack
//
//  Created by Eoin Norris on 15/01/2015.
//  Copyright (c) 2015 Occassionaly Useful Software. All rights reserved.
//

import Cocoa

struct OCSResponseType {
    enum Response {
        case DATA
        case STREAM
    }
    
    var type:Response = .DATA
    var data:NSData? = nil
    var stream:NSOutputStream? = nil
    
    
    init(){
        
    }
    
    init(type:Response){
        self.type = type
    }
    
}