//
//  OCSURLGenerator.swift
//  OCSNetworkStack
//
//  Created by Eoin Norris on 19/01/2015.
//  Copyright (c) 2015 Occassionaly Useful Software. All rights reserved.
//

import Cocoa

class OCSURLGenerator: NSObject {

    func generateURLEncodedString(baseURL:String, components:String...)->String{
        var baseURLNSString = baseURL
        var baseURLNSStringEncode = baseURLNSString.urlEncode()
        var result = baseURLNSStringEncode
        var index = 0
        for component in components{
            if (index == 0){
                result += "?"
            }
            
            if (index != 0 && index%2 == 0){
                result += "&"
            } else {
                result += "="
            }
            
            var componentEncode = component.urlEncode()
            result += componentEncode
            
            index++

        }
        return result
    }
    
    func generateURLEncodedString(baseURL:String, componentDict:[String:String])->String{
        var baseURLNSString = baseURL
        var baseURLNSStringEncode = baseURLNSString.urlEncode()
        var result = baseURLNSStringEncode
        var index = 0
        for (key,value) in componentDict{
            var encodedValue = value.urlEncode()
            
            if (index == 0){
                result += "?"
            } else {
                result += "&";
            }
            
            result = result + key + "=" + encodedValue
            
            index++
  
            
        }
        return result
    }
    
    
}
