//
//  SimulatedClientTests.swift
//  gp-aideTests
//
//  Created by Ethan Davidson on 5/4/21.
//

@testable import gp_aide
import XCTest

class RandomizedClientTests: XCTestCase {
    var client: RandomizedClient = RandomizedClient()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testFindTenClassmates() {
        self.client.fetchClassmates(taking: "CPSC 223W") { classmates in
            XCTAssertEqual(classmates.count, CLASSMATE_AMOUNT)
        }
    }
    
}
