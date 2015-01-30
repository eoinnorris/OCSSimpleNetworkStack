//
//  TwitterIntegrationTests.swift
//  OCSNetworkStack
//
//  Created by Eoin Norris on 19/01/2015.
//  Copyright (c) 2015 Occassionaly Useful Software. All rights reserved.
//

import Cocoa
import XCTest
import OCSNetworkStack


/*

POST /atp/oauth2/token HTTP/1.1
Host: wl-qa-vip.dev.newbay.com
Accept: application/json
X-Scope-Service: DV
X-Service-Identifier: DV
Accept-Language: en-us
X-Client-Platform: DesktopMac
Accept-Encoding: gzip, deflate
Content-Type: application/x-www-form-urlencoded
Content-Length: 87
X-Client-Identifier: Mac/Mac OSX 10.10.2
gzip: Accept-Encoding
User-Agent: SyncDrive/15.1.2.1 (ie_IE; DesktopMac) Mac/Mac OSX 10.10.2
Connection: keep-alive
Cookie: __utma=57927020.2061014918.1369221659.1422536422.1422540782.59; __utmz=57927020.1416488534.24.2.utmcsr=t.co|utmccn=(referral)|utmcmd=referral|utmcct=/7Qmt0OQJzP; DeleteForeverCheck=true; firstTime=true; NWB=AEdnM0pUjuu0Y3jj9vab5UMH4Md21is9h2j2GE4sVcSPLWx4_AFG4yvENuTODVAofKFaFCDS80JfXJJXVrLiqfKG0KjepsIKmYnRYn1Y9guBxItlz_uHRFAdx-TVRH42_CpouxpmwnMcl6rUFQ5erDqjg5qEgNk0CdgxUr3WhF_IvZU5GvZ66sIQcLtuJy0zPA7l5bW_DOf8i674nuYHu0-UFe-pRK_bKeaCrExMSH3Fapef5nG78t10TJFGnIQtZzLZmDnCbeRm4GRLUylrrBggvwgUQoWsxgREbravvPWJelAW-E8mXMfVuVK7WMtYUw~~; __utma=145313067.663897267.1374830180.1374830180.1374848197.2; wlssotoken="BD:NBUqqPx5GvRRuSlvNgfVON7i8Rq8QaxI"
X-Application-Identifier: SyncDrive.3c:07:54:57:a3:93_eoinnorris

grant_type=client_credentials&client_id=6666666415&client_secret=ent3r6415&tenant_id=ie
*/


class ATPBody:OCSBody{
    override var bodyStr:String?{
        get{
            return "grant_type=client_credentials&client_id=6666666415&client_secret=ent3r6415&tenant_id=ie"
        }
        
        set{
            
        }
    }
}

class ATPHeaders:OCSHeaders{
    override var bodyStr:String?{
        get{
            return "grant_type=client_credentials&client_id=6666666415&client_secret=ent3r6415&tenant_id=ie"
        }
        
        set{
            
        }
    }
}

class TwitterIntegrationTests: XCTestCase {
    
    var token:String = ""
    let kTimeOut = 10.0
    let interface = OCSHttp()
    let kATPAuth            = "http://wl-qa-vip.dev.newbay.com/atp/oauth2/token"

    
    let kAccept = "application/json"
    let kAcceptEncoding = "gzip, deflate"
    let kUserAgent = "SyncDrive/15.1.2.1 (ie_IE; DesktopMac) Mac/Mac OSX 10.10.2"
    let kContentType = "application/x-www-form-urlencoded"


    override func setUp() {
        super.setUp()
        
        // note these are all global
        OCSURLRequest.setGlobalTimeout(10.0)
        OCSURLRequest.setGlobalCache(.ReloadIgnoringLocalCacheData)

        OCSHeaders.setAcceptEncoding(kAcceptEncoding)
        OCSHeaders.setContentType(kContentType)
        OCSHeaders.setUserAgent(kUserAgent)
        OCSHeaders.appendValues(["X-Scope-Service":"DV","X-Service-Identifier":"DV","X-Client-Platform":"DesktopMac","X-Application-Identifier":"Mac/Mac OSX 10.10.2"])

        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testGetATPTokenATPBody() {
        var expectation:XCTestExpectation = self.expectationWithDescription("No Error")
        
        var urlStr = NSURL(string: kATPAuth)
        if let url = urlStr{
            var settings = OCSHttpSettings(url: url,headers:nil, body:ATPBody());
            settings.method = .POST
            self.interface.sendAsyncRequest(settings, responseFunc: { (response) -> Void in
                if let possibleData: AnyObject = response.JSONObject{
                    if let knownDictionary = possibleData as? NSDictionary{
                        XCTAssert((possibleData.count > 0), "Pass")
                    }
                }
            })
        }
        
        self.waitForExpectationsWithTimeout(kTimeOut, handler: { (NSError) -> Void in
            XCTAssert(true, "Failed - the networkTimedOut")
        })
        // This is an example of a functional test case.
    }
    
    

    func testGetATPToken() {
        var expectation:XCTestExpectation = self.expectationWithDescription("No Error")
        
        // grant_type=client_credentials&client_id=6666666415&client_secret=ent3r6415&tenant_id=ie
        var body = OCSBody(parts: ["grant_type":"client_credentials","client_id":"6666666415","client_secret":"ent3r6415","tenant_id":"ie"])
        
        var urlStr = NSURL(string: kATPAuth)
        if let url = urlStr{
            var settings = OCSHttpSettings(url: url, headers: nil, body:body);
            settings.method = .POST
            self.interface.sendAsyncRequest(settings, responseFunc: { (response) -> Void in
                if let possibleData: AnyObject = response.JSONObject{
                    if let knownDictionary = possibleData as? NSDictionary{
                        XCTAssert((possibleData.count > 0), "Pass")
                    }
                }
            })
        }
        
        self.waitForExpectationsWithTimeout(kTimeOut, handler: { (NSError) -> Void in
            XCTAssert(true, "Failed - the networkTimedOut")
        })
        // This is an example of a functional test case.
    }

    
    
    func testGetATPTokenFailsBadRequest() {
        var expectation:XCTestExpectation = self.expectationWithDescription("No Error")
        
        // two line setup
        var headers = OCSHeaders()
        var settings = OCSHttpSettings(path: kATPAuth)
        
        self.interface.sendAsyncRequest(settings, responseFunc: { (response) -> Void in
            if let response = response.internalResponse{
                if response.statusCode == 400{
                    XCTAssert(true, "Pass")
                }
            }
        })
        
        self.waitForExpectationsWithTimeout(kTimeOut, handler: { (NSError) -> Void in
            XCTAssert(true, "Failed - the networkTimedOut")
        })
        // This is an example of a functional test case.
    }
    


    
}
