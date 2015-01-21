//
//  OCSError.swift
//  OCSNetworkStack
//
//  Created by Eoin Norris on 15/01/2015.
//  Copyright (c) 2015 Occassionaly Useful Software. All rights reserved.
//

import Cocoa



class OCSError {
    
    typealias localErrorTuple = (localErrorDescription:String?,localErrorValue:Int?)
    typealias errorTuple = (systemError:NSError?,systemErrorDescription:String?,localErrorDescription:String?,localErrorValue:Int?)
    typealias networkErrorTuple = (systemError:NSError?,systemErrorDescription:String?)


    var systemError:NSError?
    var systemErrorDescription:String?
    var localErrorDescription:String?
    var localErrorValue:Int?



    enum TYPE{
        case NETWORK
        case INVALIDSETTINGS
    }
}
