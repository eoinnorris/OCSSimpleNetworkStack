//
//  TestSimpleIntegrationRequests.swift
//  OCSNetworkStack
//
//  Created by Eoin Norris on 23/01/2015.
//  Copyright (c) 2015 Occassionaly Useful Software. All rights reserved.
//

import Cocoa
import XCTest
import OCSNetworkStack


class TestSimpleIntegrationRequests: XCTestCase {
    
    let kTimeOut = 10.0
    let http = OCSHttp()
    let KiTunesJSON = "https://itunes.apple.com/us/rss/topaudiobooks/limit=5/json"
    

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK: -- Success
    

    func testSimpleJsonReturningJSONDict(){
        var expectation:XCTestExpectation = self.expectationWithDescription("No Error")
        
        
        http.sendAsyncRequest(KiTunesJSON, responseFunc:{
            if let possibleData: AnyObject = $0.JSONObject{
                if let knownDictionary = possibleData as? NSDictionary{
                    XCTAssert((possibleData.count > 0), "Pass")
                }
            }
            expectation.fulfill()
        })
        
        self.waitForExpectationsWithTimeout(kTimeOut, handler: { (NSError) -> Void in
            XCTAssert(true, "Failed - the networkTimedOut")
        })
    }

    
    func testSimpleJsonReturningString(){
        var expectation:XCTestExpectation = self.expectationWithDescription("No Error")
        
        // two line setu
        http.sendAsyncRequest(KiTunesJSON, responseFunc:{
            if let possibleStr = $0.string{
                XCTAssert((possibleStr.isEmpty == false), "Pass")
                expectation.fulfill()
            }
        })
        
        self.waitForExpectationsWithTimeout(kTimeOut, handler: { (NSError) -> Void in
            XCTAssert(true, "Failed - the networkTimedOut")
        })
    }
    
    
    func testSimpleJsonReturningDataVerbose(){
        var expectation:XCTestExpectation = self.expectationWithDescription("No Error")
        
        // two line setup
        var settings:OCSHttpSettings = OCSNetworkStack.OCSHttpSettings(path: KiTunesJSON)
        
        http.sendAsyncRequest(settings, responseFunc: { (response) -> Void in
            if let possibleData = response.data{
                XCTAssert((possibleData.length > 0), "Pass")
                expectation.fulfill()
            }
        })
        
        self.waitForExpectationsWithTimeout(kTimeOut, handler: { (NSError) -> Void in
            XCTAssert(true, "Failed - the networkTimedOut")
        })
    }
    
    
    func testSimpleJsonAsData(){
        var expectation:XCTestExpectation = self.expectationWithDescription("No Error")
    
        http.sendAsyncRequest(OCSHttpSettings(path: KiTunesJSON), responseFunc: {
            if let possibleData = $0.data{
                XCTAssert((possibleData.length > 0), "Pass")
                expectation.fulfill()
            }
        })
        
        self.waitForExpectationsWithTimeout(kTimeOut, handler: { (NSError) -> Void in
            XCTAssert(true, "Failed - the networkTimedOut")
        })
    }
    
    // MARK: -- Failures

    func testSimpleJsonReturningNSXMLDocumentFails(){
        var expectation:XCTestExpectation = self.expectationWithDescription("No Error")
        
        http.sendAsyncRequest(OCSHttpSettings(path: KiTunesJSON), responseFunc:{
            if let possibleData: AnyObject = $0.xmlDocument{
                XCTAssert(false, "Fail - this isnt an XML query")
            } else {
                XCTAssert(true, "Pass")
            }
            expectation.fulfill()
        })
        
        self.waitForExpectationsWithTimeout(kTimeOut, handler: { (NSError) -> Void in
            XCTAssert(true, "Failed - the networkTimedOut")
        })
    }
    
    
    func testSimpleJsonReturningXMLStringFails(){
        var expectation:XCTestExpectation = self.expectationWithDescription("No Error")
        
        // two line setup
        var settings:OCSHttpSettings = OCSNetworkStack.OCSHttpSettings(path: KiTunesJSON)
        
        http.sendAsyncRequest(settings, responseFunc:{
            if let possibleStr = $0.xmlString{
                XCTAssert((possibleStr.isEmpty == true), "Pass")
            } else {
                XCTAssert(true,"Pass")
            }
            expectation.fulfill()
        })
        
        self.waitForExpectationsWithTimeout(kTimeOut, handler: { (NSError) -> Void in
            XCTAssert(true, "Failed - the networkTimedOut")
        })
    }

}
