//
//  SimulatedClientTests.swift
//  gp-aideTests
//
//  Created by Ethan Davidson on 4/18/21.
//

@testable import gp_aide
import XCTest

class SimulatedClientTests: XCTestCase {
    var client: SimulatedClient = SimulatedClient()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testClassmatesCount() {
        let classmatesCount = TEST_CLASSMATES
        XCTAssertEqual(classmatesCount.count, 4)
    }
    
    func testFoundClassmatesByClassOne() {
        let testCourse = "CPSC 223W"
        self.client.fetchClassmates(taking: testCourse) { foundClassmates in
            XCTAssertEqual(foundClassmates.count, 4)
        }
    }
    
    func testFoundClassmatesByClassTwo() {
        let testCourse = "CPSC 481"
        self.client.fetchClassmates(taking: testCourse) { foundClassmates in
            XCTAssertEqual(foundClassmates.count, 2)
        }
    }
    
    func testFoundClassmatesByClassThree() {
        let testCourse = "CPSC 315"
        self.client.fetchClassmates(taking: testCourse) { foundClassmates in
            XCTAssertEqual(foundClassmates.count, 1)
        }
    }
    
    func testFoundClassmatesByClassFour() {
        let testCourse = "CPSC 411"
        self.client.fetchClassmates(taking: testCourse) { foundClassmates in
            XCTAssertEqual(foundClassmates.count, 1)
        }
    }

    func testNoClassmatesMatch() {
        self.client.fetchClassmates(taking: "courseTitle1") { classmates in
            XCTAssertEqual(classmates.count, 0)
        }
    }

    func testPullInfo() {
        self.client.pullInfo(username: TEST_USER.username, password: TEST_USER.hashedPassword) { info in
            XCTAssertEqual(info, TEST_USER)
        }
    }

    func testPushInfo() {
        self.client.pushInfo(TEST_USER) { response in
            XCTAssertTrue(response.isSuccessful)
        }
    }

    func testDiscardInfo() {
        self.client.discardInfo(TEST_USER) { response in
            XCTAssertTrue(response.isSuccessful)
        }
    }
    
    
}
