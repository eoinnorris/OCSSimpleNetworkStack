//
//  OCSSession.swift
//  OCSNetworkStack
//
//  Created by Eoin Norris on 15/01/2015.
//  Copyright (c) 2015 Occassionaly Useful Software. All rights reserved.
//

import Cocoa

// Continuous uses NSURLSession, nonContinuous uses NSURLConnection
struct OCSSession{
    
    enum Type{
        case Continuous
        case NonContinuous
    }
    
    var type: Type = .NonContinuous
}

