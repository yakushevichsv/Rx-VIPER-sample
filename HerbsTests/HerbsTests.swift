//
//  HerbsTests.swift
//  HerbsTests
//
//  Created by Siarhei Yakushevich on 12/12/16.
//  Copyright © 2016 Siarhei Yakushevich. All rights reserved.
//

import XCTest
import RxSwift
@testable import Herbs

class HerbsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}

class NetworkManagerTests: XCTestCase {
    var manager: NetworkProtocol! = nil
    let bag = DisposeBag()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        manager = NetworkManager()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        manager = nil
    }
    
    func testAccessAllHerbs() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let expectation = self.expectation(description: "Access all herbs")
        
        manager.accessAllHerbs().subscribe(onNext: {
            guard let array = $0 else {
                expectation.fulfill()
                return // Might be if network errors were encountered
            }
            
            XCTAssertTrue(array.count != 0)
            
        }).addDisposableTo(bag)
        
        waitForExpectations(timeout: 5) {
            XCTAssertNil($0)
        }
    }
}
