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

//MARK: - NetworkManagerTests
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
                return // Might be if network errors were encountered
            }
            
            XCTAssertTrue(array.count != 0)
            expectation.fulfill()
        },onError:{ (error) in
            XCTAssert(error.isNetworkIssue)
            expectation.fulfill()
        }).addDisposableTo(bag)
        
        waitForExpectations(timeout: 8) {
            XCTAssertNil($0)
        }
    }
}
