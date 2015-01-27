//
//  OCSError.swift
//  OCSNetworkStack
//
//  Created by Eoin Norris on 15/01/2015.
//  Copyright (c) 2015 Occassionaly Useful Software. All rights reserved.
//

import Cocoa

enum ErrorType{
    case NETWORK
    case INVALIDSETTINGS
    case UNKNOWN
}

struct OCSError {

    var systemError:NSError?
    var localError:NSError?
    var type:ErrorType

   
    
    init(systemError:NSError){
        self.systemError = systemError
        self.type = .NETWORK
    }
    
    init(localError:NSError){
        self.localError = localError
        self.type = .INVALIDSETTINGS
    }
}
