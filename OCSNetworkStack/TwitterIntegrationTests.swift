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


class TwitterIntegrationTests: XCTestCase {
    
    var token:String = ""
    let kTimeOut = 10.0
    let interface = OCSHttp()
    let kTwitterAuth = "https://api.twitter.com/oauth2/token"
    let kJSONPlaceHolderPosts = "http://jsonplaceholder.typicode.com/posts/1"

    override func setUp() {
        super.setUp()
        OCSURLRequest.setGlobalTimeout(10.0)
        OCSURLRequest.setGlobalCache(.ReloadIgnoringLocalCacheData)

        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    

    
    func testGetTwitterTokenFailsBadRequest() {
        var expectation:XCTestExpectation = self.expectationWithDescription("No Error")
        
        // two line setup
        var headers = OCSHeaders()
        var settings = OCSHttpSettings(path: kTwitterAuth)
        
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
    

    func testGetTwitterTokenFailsBadRequestOneLine() {
     var expectation:XCTestExpectation = self.expectationWithDescription("No Error")
        
        self.interface.sendAsyncRequest(OCSHttpSettings(path: kTwitterAuth), responseFunc: { (response) -> Void in
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
    
    func testGetTwitterTokenFailsBadRequestInferredEnclosure() {
        var expectation:XCTestExpectation = self.expectationWithDescription("No Error")
        
        // enclosure with inferred paramater lists.
        self.interface.sendAsyncRequest(OCSHttpSettings(path: kTwitterAuth), responseFunc: {
            if let response = $0.internalResponse{
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
