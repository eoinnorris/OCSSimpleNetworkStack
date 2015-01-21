//
//  OCSSimpleNetworkErrorGenerator.swift
//  OCSNetworkStack
//
//  Created by Eoin Norris on 14/01/2015.
//  Copyright (c) 2015 Occassionaly Useful Software. All rights reserved.
//

import Cocoa

typealias ErrorValue = (String,Int)


class OCSSimpleNetworkErrorGenerator: NSObject {

    let settingsMissing     = (1,"No OCSSettings object instantiate")
    let pathMissing         = (1001,"No path added to request")

    let headersMissing      = (2004,"No headers added to request")
    let bodyMissing         = (3002,"No body added to request")
    let formsMissing        = (4003,"No Forms added to form request")
    
}
