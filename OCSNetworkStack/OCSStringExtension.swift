//
//  OCSStringExtension.swift
//  OCSNetworkStack
//
//  Created by Eoin Norris on 19/01/2015.
//  Copyright (c) 2015 Occassionaly Useful Software. All rights reserved.
//

import Cocoa

extension Character {
    func utf8Value() -> UInt8 {
        for s in String(self).utf8 {
            return s
        }
        return 0
    }
    
    func utf16Value() -> UInt16 {
        for s in String(self).utf16 {
            return s
        }
        return 0
    }
    
    func unicodeValue() -> UInt32 {
        for s in String(self).unicodeScalars {
            return s.value
        }
        return 0
    }
}


extension String {
    
    func base64Encoded() -> String {
        let plainData = dataUsingEncoding(NSUTF8StringEncoding)
        let base64String = plainData?.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(0))
        return base64String!
    }
    
    func base64Decoded() -> String {
        let decodedData = NSData(base64EncodedString: self, options:NSDataBase64DecodingOptions(0))
        let decodedString = NSString(data: decodedData!, encoding: NSUTF8StringEncoding)
        return decodedString!
    }


    func urlEncode()->String{
        var generator = self.generate()
        var output = ""
        for thisChar in self{
            if thisChar == " "{
                output = output + "+"
            } else if (thisChar == "." || thisChar == "-" || thisChar == "_" || thisChar == "~" ||
            (thisChar >= "a" && thisChar <= "z") ||
            (thisChar >= "A" && thisChar <= "Z") ||
            (thisChar >= "0" && thisChar <= "9")) {
                output.append(thisChar)
            } else {
                var st = NSString(format:"%2X", thisChar.utf8Value()) as String
                output = output + "%\(st)"
            }
            
        }
        
        
        return output
    }

}
