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

//MARK: - NetworkHerbProtocolTests
class NetworkHerbProtocolTests: XCTestCase {
    var manager: NetworkHerbProtocol! = nil
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
    
    func testCancelAllHerbs() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let expectation = self.expectation(description: "Cancel all herbs")
        
        
        
        let disposable = manager.accessAllHerbs().subscribe(onError: { (error) in
            XCTAssert(error.isNetworkIssue)
        }, onCompleted: { 
            XCTAssert(false)
        })
        bag.insert(disposable)
        
        disposable.dispose()
        
        Observable<Void>.empty().timeout(0.5, scheduler: MainScheduler.instance).subscribe { (error) in
            
            expectation.fulfill()
        }.addDisposableTo(bag)
        
        waitForExpectations(timeout: 8) {
            XCTAssertNil($0)
        }
    }
}

//MARK: - NetworkHerbProtocolTests
class NetworkGoogleSearchProtocolTests: XCTestCase {
    var manager: NetworkGoogleSearchProtocol! = nil
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
    
    func testImageSearch() {
        
        let expectation = self.expectation(description: #function)
        let expectCount = 2
        let query = "Donald"
        manager.searchImages(query: query, startNumber: 1, count: expectCount).filterNil().subscribe(onNext: { (items) in
            XCTAssertTrue(items.count == expectCount)
            XCTAssert(items.first?.title.uppercased().contains(query.uppercased()) == true)
            expectation.fulfill()
        }, onError: { (error) in
            XCTAssert(error.isNetworkIssue)
            expectation.fulfill()
        }).addDisposableTo(bag)
    
        
        waitForExpectations(timeout: 8) {
            XCTAssertNil($0)
        }
    }
}

