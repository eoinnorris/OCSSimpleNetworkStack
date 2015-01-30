//
//  XMLIntegrationRequests.swift
//  OCSNetworkStack
//
//  Created by Eoin Norris on 27/01/2015.
//  Copyright (c) 2015 Occassionaly Useful Software. All rights reserved.
//

import Cocoa
import XCTest
import OCSNetworkStack

class XMLIntegrationRequests: XCTestCase {
    
    let KiTunesRSS = "https://itunes.apple.com/us/rss/topaudiobooks/limit=5/xml"
    let http = OCSHttp()
    let kTimeOut = 10.0


    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testSimpleNSXMLDocument(){
        var expectation:XCTestExpectation = self.expectationWithDescription("No Error")
        
        http.sendAsyncRequest(KiTunesRSS, responseFunc:{
            if let possibleData:NSXMLDocument = $0.xmlDocument{
                XCTAssert((possibleData.documentContentKind == NSXMLDocumentContentKind.XMLKind), "Fail - this isnt an XML query")
            } else {
                XCTAssert(true, "Pass")
            }
            expectation.fulfill()
        })
        
        self.waitForExpectationsWithTimeout(kTimeOut, handler: { (NSError) -> Void in
            XCTAssert(true, "Failed - the networkTimedOut")
        })
    }
    
    
    func testSimpleXMLData(){
        var expectation:XCTestExpectation = self.expectationWithDescription("No Error")
        
        
        http.sendAsyncRequest(KiTunesRSS, responseFunc:{
            if let possibleData = $0.data{
                XCTAssert((possibleData.length > 0), "Pass")
            } else {
                XCTAssert(false,"Fail")
            }
            expectation.fulfill()
        })
        
        self.waitForExpectationsWithTimeout(kTimeOut, handler: { (NSError) -> Void in
            XCTAssert(true, "Failed - the networkTimedOut")
        })
    }
    
    
    func testSimpleXMLString(){
        var expectation:XCTestExpectation = self.expectationWithDescription("No Error")
        
        
        http.sendAsyncRequest(KiTunesRSS, responseFunc:{
            if let possibleStr = $0.xmlString{
                XCTAssert((possibleStr.isEmpty == false), "Pass")
            } else {
                XCTAssert(false,"Fail")
            }
            expectation.fulfill()
        })
        
        self.waitForExpectationsWithTimeout(kTimeOut, handler: { (NSError) -> Void in
            XCTAssert(true, "Failed - the networkTimedOut")
        })
    }

}
