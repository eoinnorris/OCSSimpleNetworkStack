//
//  OCSErrorGenerator.swift
//  OCSNetworkStack
//
//  Created by Eoin Norris on 22/01/2015.
//  Copyright (c) 2015 Occassionaly Useful Software. All rights reserved.
//

import Cocoa


let kGenericError       = "OCS Unknown error"
let kInvalidSettings    = "OCS Internal Settings Error"
let kNetworkError       = "OCS Network Error"

let kInvalidSettingsMissingURL              = "Missing URL"
let kInvalidSettingsBadHeaders              = "Missing Headers. settings.bodyType is set to .Headers so settings.Headers() struct should not be nil"
let kInvalidSettingsBadBody                 = "Missing Headers. settings.bodyType is set to .Body so settings.Body() should not be nil"
let kInvalidSettingsBadForms                = "Missing Headers. settings.bodyType is set to .Forms so settings.Forms() should not be nil"
let kInvalidSettingsBadCustomDeSerialiser   = "Missing Custom DeSerialiser. settings.deSerialisationType is set to .CUSTOM so settings.deSerialisationFunc should not be nil"



struct OCSErrorGenerator {

    
    var arrayMap = [Int: String]()

    init() {
        arrayMap[4001] = kInvalidSettingsMissingURL
        arrayMap[5001] = kInvalidSettingsBadHeaders
        arrayMap[5002] = kInvalidSettingsBadBody
        arrayMap[5003] = kInvalidSettingsBadForms

        arrayMap[6001] = kInvalidSettingsBadCustomDeSerialiser
    }
    
    internal func getStringForCode(errorCode:NSInteger)->String{
        var result = arrayMap[errorCode]
        if let realResult = result{
            return realResult
        }
        return kGenericError
    }
    
    internal func generateDomainStrForErrorType(errorType:ErrorType)->String{
        var result = kGenericError
        switch(errorType){
            case .INVALIDSETTINGS:
                result = kInvalidSettings
            case .NETWORK:
                result = kNetworkError
            case .UNKNOWN:
                result = kGenericError
            default:
                result = kGenericError

        }
        
        return result
    }
    
    internal func generateErrorFor(domain:String, errorType:ErrorType, errorNumber:NSInteger)->OCSError{
        var domain = self.generateDomainStrForErrorType(errorType)
        var text = self .getStringForCode(errorNumber);
        var error = NSError(domain: domain, code: errorNumber, userInfo: ["Type":text])
        return OCSError(localError: error)
    }
    
}
