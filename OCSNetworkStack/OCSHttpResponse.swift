//
//  OCSNetworkResponse.swift
//  OCSNetworkStack
//
//  Created by Eoin Norris on 15/01/2015.
//  Copyright (c) 2015 Occassionaly Useful Software. All rights reserved.
//

import Cocoa

public struct OCSHttpResponse{
    
    
    // internal data returned if any
    public var data:NSMutableData?
    
    
    public var xmlDocument:NSXMLDocument?{
        get{
            var validStr:String? = self.string
            var doc:NSXMLDocument? = nil
            if  validStr != nil{
                var error:NSError? = nil
                doc = NSXMLDocument(XMLString: validStr!, options: 0, error: &error)
                if let realError = error{
                    doc = nil
                } else {
                    if let actualDoc = doc{
                        let isValid = actualDoc.validateAndReturnError(&error)
                        if isValid == false{
                            doc = nil
                        }
                    }
                }
            }
            return doc
        }
    }

    
    /// Use this if you are uncertain if the returning data is XML.
    // if you are sure it is correct xml then you can safely use String
    public var xmlString:String?{
        get{
            var validStr:String? = nil
            var doc:NSXMLDocument? = self.xmlDocument
            if let realDoc = doc{
                validStr = self.string
            } else {
                validStr = nil
            }
            return validStr
        }
    }
    
    
    public var string:String?{
        get{
            if let data = self.data{
                return NSString(data: data, encoding: NSUTF8StringEncoding)
            }
            return nil
        }
    }
    
    public var JSONObject:AnyObject?{
        get{
            var result:AnyObject? = nil
            if let data = self.data{
                var jsonError:NSError? = nil
                  var jsonResult: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &jsonError)
                     result = jsonResult!
            }
            return result
        }
    }
    
    var stream:NSOutputStream?

    // reponse of errors if any
    public var error:NSError? = nil
    public var internalResponse:NSHTTPURLResponse? = nil
    
    var isStreaming:Bool{
        get{
            return (stream != nil)
        }
    }
    
    init(error:NSError){
        self.error = error
    }
    
    init(stream:NSOutputStream){
        self.stream = stream
    }
    
    init(){
        self.data = NSMutableData();
    }
    
    public func appendData(inData:NSData){
        if isStreaming == false{
            self.data!.appendData(inData)
        } else {
            // add to open stream
        }
    }
}

